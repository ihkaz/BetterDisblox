--!strict

local EventEmitter = require("../util/EventEmitter")
local GatewayOpcode = require("./GatewayOpcode")
local Json = require("../util/Json")
local SessionStore = require("../storage/SessionStore")

export type GatewayClientOptions = {
	Token: string,
	Intents: number,
	Url: string?,
	AutoReconnect: boolean?,
	ReconnectDelay: number?,
	MaxReconnectAttempts: number?,
	SessionPersistence: boolean?,
	SessionFolder: string?,
	SessionFileName: string?,
}

export type GatewayClient = {
	On: (self: GatewayClient, eventName: string, callback: (...any) -> ()) -> any,
	Once: (self: GatewayClient, eventName: string, callback: (...any) -> ()) -> any,
	Connect: (self: GatewayClient) -> (),
	Disconnect: (self: GatewayClient) -> (),
	Send: (self: GatewayClient, payload: any) -> (),
	SetPresence: (self: GatewayClient, presence: any) -> (),
}

local GatewayClient = {}
GatewayClient.__index = GatewayClient

local DEFAULT_GATEWAY_URL = "wss://gateway.discord.gg/?v=10&encoding=json"
local DEFAULT_RECONNECT_DELAY = 5
local DEFAULT_MAX_RECONNECT_ATTEMPTS = 0

local function getWebSocketConnect(): (string) -> any
	local websocketTable = WebSocket or websocket
	if type(websocketTable) ~= "table" or type(websocketTable.connect) ~= "function" then
		error("UNC WebSocket.connect is unavailable. This executor must support WebSocket.connect(url).", 2)
	end

	return websocketTable.connect
end

local function emitDebug(self: any, message: string, fields: any): ()
	self.emitter:Emit("DEBUG", {
		message = message,
		fields = fields,
	})
end

local function connectSignal(socket: any, signalName: string, callback: (...any) -> ()): ()
	local signal = socket[signalName]

	if type(signal) == "table" or type(signal) == "userdata" then
		if type(signal.Connect) == "function" then
			signal:Connect(callback)
			return
		end
	end

	if type(signal) == "function" then
		signal(callback)
		return
	end

	socket[signalName] = callback
end

function GatewayClient.new(options: GatewayClientOptions): GatewayClient
	if type(options.Token) ~= "string" or options.Token == "" then
		error("Discord bot token must be a non-empty string", 2)
	end

	if type(options.Intents) ~= "number" then
		error("Gateway intents must be a number", 2)
	end

	local url = options.Url
	if url == nil then
		url = DEFAULT_GATEWAY_URL
	end

	local autoReconnect = options.AutoReconnect
	if autoReconnect == nil then
		autoReconnect = true
	end

	local reconnectDelay = options.ReconnectDelay
	if reconnectDelay == nil then
		reconnectDelay = DEFAULT_RECONNECT_DELAY
	end

	local maxReconnectAttempts = options.MaxReconnectAttempts
	if maxReconnectAttempts == nil then
		maxReconnectAttempts = DEFAULT_MAX_RECONNECT_ATTEMPTS
	end

	local self = {
		token = options.Token,
		intents = options.Intents,
		url = url,
		socket = nil :: any,
		sequence = nil :: number?,
		sessionId = nil :: string?,
		resumeGatewayUrl = nil :: string?,
		heartbeatInterval = nil :: number?,
		heartbeatThread = nil :: thread?,
		lastHeartbeatAck = true,
		emitter = EventEmitter.new(),
		closed = false,
		autoReconnect = autoReconnect,
		reconnectDelay = reconnectDelay,
		maxReconnectAttempts = maxReconnectAttempts,
		reconnectAttempts = 0,
		sessionPersistence = options.SessionPersistence == true,
		sessionStore = SessionStore.new(options.SessionFolder, options.SessionFileName),
		resumeRequested = false,
	}

	return (setmetatable(self, GatewayClient) :: any) :: GatewayClient
end

function GatewayClient:On(eventName: string, callback: (...any) -> ()): any
	return (self :: any).emitter:On(eventName, callback)
end

function GatewayClient:Once(eventName: string, callback: (...any) -> ()): any
	return (self :: any).emitter:Once(eventName, callback)
end

function GatewayClient:Send(payload: any): ()
	local state = self :: any
	if state.socket == nil then
		error("Cannot send Gateway payload before connecting", 2)
	end

	local encoded = Json.Encode(payload)
	state.socket:Send(encoded)
end

function GatewayClient:SetPresence(presence: any): ()
	self:Send({
		op = GatewayOpcode.PRESENCE_UPDATE,
		d = presence,
	})
end

function GatewayClient:Disconnect(): ()
	local state = self :: any
	state.closed = true

	if state.socket ~= nil then
		state.socket:Close()
	end

	state.socket = nil
end

local function saveSession(self: any): ()
	if not self.sessionPersistence then
		return
	end

	if not self.sessionId or not self.resumeGatewayUrl then
		return
	end

	self.sessionStore:Save({
		sessionId = self.sessionId,
		sequence = self.sequence,
		resumeGatewayUrl = self.resumeGatewayUrl,
	})
end

local function loadSession(self: any): ()
	if not self.sessionPersistence then
		return
	end

	local session = self.sessionStore:Load()
	if session == nil then
		return
	end

	self.sessionId = session.sessionId
	self.sequence = session.sequence
	self.resumeGatewayUrl = session.resumeGatewayUrl
end

local function clearSession(self: any): ()
	self.sessionId = nil
	self.sequence = nil
	self.resumeGatewayUrl = nil

	if self.sessionPersistence then
		self.sessionStore:Clear()
	end
end

local function startHeartbeat(self: any, intervalMilliseconds: number): ()
	self.heartbeatInterval = intervalMilliseconds / 1000
	self.lastHeartbeatAck = true
	emitDebug(self, "Gateway heartbeat started", {
		interval = self.heartbeatInterval,
	})

	self.heartbeatThread = task.spawn(function()
		while not self.closed and self.socket ~= nil do
			task.wait(self.heartbeatInterval)

			if not self.lastHeartbeatAck then
				self.emitter:Emit("ERROR", "Discord Gateway heartbeat ACK was not received before the next heartbeat")
				self.socket:Close()
				return
			end

			self.lastHeartbeatAck = false
			self:Send({
				op = GatewayOpcode.HEARTBEAT,
				d = self.sequence,
			})
		end
	end)
end

local function identify(self: any): ()
	emitDebug(self, "Gateway identify sent", {
		intents = self.intents,
	})

	self:Send({
		op = GatewayOpcode.IDENTIFY,
		d = {
			token = self.token,
			intents = self.intents,
			properties = {
				os = "roblox",
				browser = "DiscordExecutorLuau",
				device = "DiscordExecutorLuau",
			},
		},
	})
end

local function canResume(self: any): boolean
	return type(self.sessionId) == "string" and self.sessionId ~= "" and type(self.sequence) == "number"
end

local function resume(self: any): ()
	self.resumeRequested = true
	emitDebug(self, "Gateway resume sent", {
		sessionId = self.sessionId,
		sequence = self.sequence,
	})

	self:Send({
		op = GatewayOpcode.RESUME,
		d = {
			token = self.token,
			session_id = self.sessionId,
			seq = self.sequence,
		},
	})
end

local function handleDispatch(self: any, eventName: string, data: any, sequence: number?): ()
	self.sequence = sequence
	self.emitter:Emit("RAW", {
		t = eventName,
		s = sequence,
		d = data,
	})
	emitDebug(self, "Gateway dispatch received", {
		event = eventName,
		sequence = sequence,
	})

	if eventName == "READY" and type(data) == "table" then
		self.sessionId = data.session_id
		self.resumeGatewayUrl = data.resume_gateway_url
		self.reconnectAttempts = 0
		self.resumeRequested = false
		saveSession(self)
	end

	if eventName == "RESUMED" then
		self.reconnectAttempts = 0
		self.resumeRequested = false
		saveSession(self)
	end

	self.emitter:Emit(eventName, data)
end

local function handlePayload(self: any, payload: any): ()
	if type(payload) ~= "table" then
		self.emitter:Emit("ERROR", "Gateway payload must be a table")
		return
	end

	if type(payload.s) == "number" then
		self.sequence = payload.s
	end

	if payload.op == GatewayOpcode.HELLO then
		emitDebug(self, "Gateway hello received", payload.d)
		startHeartbeat(self, payload.d.heartbeat_interval)
		if canResume(self) then
			resume(self)
		else
			identify(self)
		end
		return
	end

	if payload.op == GatewayOpcode.DISPATCH then
		handleDispatch(self, payload.t, payload.d, payload.s)
		return
	end

	if payload.op == GatewayOpcode.HEARTBEAT_ACK then
		emitDebug(self, "Gateway heartbeat ACK received", {
			sequence = self.sequence,
		})
		self.lastHeartbeatAck = true
		return
	end

	if payload.op == GatewayOpcode.RECONNECT then
		emitDebug(self, "Gateway reconnect requested", payload.d)
		self.emitter:Emit("RECONNECT", payload.d)
		self.socket:Close()
		return
	end

	if payload.op == GatewayOpcode.INVALID_SESSION then
		emitDebug(self, "Gateway invalid session received", {
			resumable = payload.d,
		})
		clearSession(self)
		self.resumeRequested = false
		self.emitter:Emit("INVALID_SESSION", payload.d)
		task.wait(1)
		identify(self)
	end
end

local function getSocketMessage(...: any): string?
	local arguments = table.pack(...)

	for index = 1, arguments.n do
		if type(arguments[index]) == "string" then
			return arguments[index]
		end
	end

	for index = 1, arguments.n do
		local argument = arguments[index]
		if type(argument) == "table" then
			if type(argument.Data) == "string" then
				return argument.Data
			end

			if type(argument.data) == "string" then
				return argument.data
			end

			if type(argument.Message) == "string" then
				return argument.Message
			end

			if type(argument.message) == "string" then
				return argument.message
			end
		end
	end

	return nil
end

local function describeSocketMessage(...: any): string
	local arguments = table.pack(...)
	local types: { string } = {}

	for index = 1, arguments.n do
		table.insert(types, type(arguments[index]))
	end

	return table.concat(types, ", ")
end

local function bindSocket(self: any): ()
	connectSignal(self.socket, "OnMessage", function(...: any)
		local message = getSocketMessage(...)
		if message == nil then
			self.emitter:Emit("ERROR", "Gateway WebSocket message did not include a string payload. Argument types: " .. describeSocketMessage(...))
			return
		end

		emitDebug(self, "Gateway message received", {
			size = #message,
		})

		local success, decoded = pcall(function()
			return Json.Decode(message)
		end)

		if not success then
			self.emitter:Emit("ERROR", tostring(decoded) .. " payload=" .. string.sub(message, 1, 200))
			return
		end

		handlePayload(self, decoded)
	end)

	connectSignal(self.socket, "OnClose", function(...)
		local closeArguments = table.pack(...)
		self.socket = nil
		self.emitter:Emit("CLOSE", table.unpack(closeArguments, 1, closeArguments.n))
		emitDebug(self, "Gateway socket closed", {
			arguments = closeArguments,
		})

		if self.closed or not self.autoReconnect then
			return
		end

		if self.maxReconnectAttempts > 0 and self.reconnectAttempts >= self.maxReconnectAttempts then
			self.emitter:Emit("ERROR", "Discord Gateway reconnect limit reached")
			return
		end

		self.reconnectAttempts += 1
		self.emitter:Emit("RECONNECTING", {
			attempt = self.reconnectAttempts,
			delay = self.reconnectDelay,
			canResume = canResume(self),
		})

		task.wait(self.reconnectDelay)
		self:Connect()
	end)
end

function GatewayClient:Connect(): ()
	local state = self :: any
	if state.socket ~= nil then
		error("Gateway client is already connected or connecting", 2)
	end

	if state.sessionPersistence and state.sessionId == nil then
		loadSession(state)
	end

	state.closed = false
	local gatewayUrl = state.url
	if canResume(state) and type(state.resumeGatewayUrl) == "string" and state.resumeGatewayUrl ~= "" then
		gatewayUrl = state.resumeGatewayUrl .. "?v=10&encoding=json"
	end

	emitDebug(state, "Gateway connecting", {
		url = gatewayUrl,
		resume = canResume(state),
	})

	state.socket = getWebSocketConnect()(gatewayUrl)
	bindSocket(state)
	emitDebug(state, "Gateway socket bound", nil)
end

return GatewayClient
