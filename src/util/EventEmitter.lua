--!strict

export type Disconnectable = {
	Disconnect: (self: Disconnectable) -> (),
}

export type EventEmitter = {
	On: (self: EventEmitter, eventName: string, callback: (...any) -> ()) -> Disconnectable,
	Once: (self: EventEmitter, eventName: string, callback: (...any) -> ()) -> Disconnectable,
	Emit: (self: EventEmitter, eventName: string, ...any) -> (),
	EmitSync: (self: EventEmitter, eventName: string, ...any) -> (),
	RemoveAllListeners: (self: EventEmitter, eventName: string) -> (),
}

type Listener = {
	callback: (...any) -> (),
	once: boolean,
}

type EventEmitterState = {
	listeners: { [string]: { Listener } },
}

local EventEmitter = {}
EventEmitter.__index = EventEmitter

function EventEmitter.new(): EventEmitter
	local self: EventEmitterState = {
		listeners = {},
	}

	return (setmetatable(self, EventEmitter) :: any) :: EventEmitter
end

function EventEmitter:On(eventName: string, callback: (...any) -> ()): Disconnectable
	if type(eventName) ~= "string" or eventName == "" then
		error("eventName must be a non-empty string", 2)
	end

	if type(callback) ~= "function" then
		error("callback must be a function", 2)
	end

	local state = self :: any
	local listener: Listener = {
		callback = callback,
		once = false,
	}

	local eventListeners = state.listeners[eventName]
	if eventListeners == nil then
		eventListeners = {}
		state.listeners[eventName] = eventListeners
	end

	table.insert(eventListeners, listener)

	local disconnected = false
	local disconnectable = {}

	function disconnectable:Disconnect()
		if disconnected then
			return
		end

		disconnected = true
		local currentListeners = state.listeners[eventName]
		if currentListeners == nil then
			return
		end

		local nextListeners: { Listener } = {}
		for _, currentListener in ipairs(currentListeners) do
			if currentListener ~= listener then
				table.insert(nextListeners, currentListener)
			end
		end

		state.listeners[eventName] = nextListeners
	end

	return disconnectable :: Disconnectable
end

function EventEmitter:Once(eventName: string, callback: (...any) -> ()): Disconnectable
	if type(eventName) ~= "string" or eventName == "" then
		error("eventName must be a non-empty string", 2)
	end

	if type(callback) ~= "function" then
		error("callback must be a function", 2)
	end

	local state = self :: any
	local listener: Listener = {
		callback = callback,
		once = true,
	}

	local eventListeners = state.listeners[eventName]
	if eventListeners == nil then
		eventListeners = {}
		state.listeners[eventName] = eventListeners
	end

	table.insert(eventListeners, listener)

	local disconnected = false
	local disconnectable = {}

	function disconnectable:Disconnect()
		if disconnected then
			return
		end

		disconnected = true
		local currentListeners = state.listeners[eventName]
		if currentListeners == nil then
			return
		end

		local nextListeners: { Listener } = {}
		for _, currentListener in ipairs(currentListeners) do
			if currentListener ~= listener then
				table.insert(nextListeners, currentListener)
			end
		end

		state.listeners[eventName] = nextListeners
	end

	return disconnectable :: Disconnectable
end

function EventEmitter:Emit(eventName: string, ...: any): ()
	if type(eventName) ~= "string" or eventName == "" then
		error("eventName must be a non-empty string", 2)
	end

	local state = self :: any
	local eventListeners = state.listeners[eventName]
	if eventListeners == nil then
		return
	end

	local arguments = table.pack(...)
	local nextListeners: { Listener } = {}

	for _, listener in ipairs(eventListeners) do
		task.spawn(function()
			local success, result = pcall(function()
				listener.callback(table.unpack(arguments, 1, arguments.n))
			end)

			if not success and eventName ~= "ERROR" then
				self:Emit("ERROR", result)
			end
		end)

		if not listener.once then
			table.insert(nextListeners, listener)
		end
	end

	state.listeners[eventName] = nextListeners
end

function EventEmitter:EmitSync(eventName: string, ...: any): ()
	if type(eventName) ~= "string" or eventName == "" then
		error("eventName must be a non-empty string", 2)
	end

	local state = self :: any
	local eventListeners = state.listeners[eventName]
	if eventListeners == nil then
		return
	end

	local arguments = table.pack(...)
	local nextListeners: { Listener } = {}

	for _, listener in ipairs(eventListeners) do
		local success, result = pcall(function()
			listener.callback(table.unpack(arguments, 1, arguments.n))
		end)

		if not success and eventName ~= "ERROR" then
			self:EmitSync("ERROR", result)
		end

		if not listener.once then
			table.insert(nextListeners, listener)
		end
	end

	state.listeners[eventName] = nextListeners
end

function EventEmitter:RemoveAllListeners(eventName: string): ()
	if type(eventName) ~= "string" or eventName == "" then
		error("eventName must be a non-empty string", 2)
	end

	local state = self :: any
	state.listeners[eventName] = {}
end

return EventEmitter
