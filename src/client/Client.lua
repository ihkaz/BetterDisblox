--!strict

local GatewayClient = require("../gateway/GatewayClient")
local Interaction = require("../structures/Interaction")
local Message = require("../structures/Message")
local RestClient = require("../rest/RestClient")

export type ClientOptions = {
	Token: string,
	Intents: number,
	GatewayUrl: string?,
	RestBaseUrl: string?,
	AutoReconnect: boolean?,
	ReconnectDelay: number?,
	MaxReconnectAttempts: number?,
	SessionPersistence: boolean?,
	SessionFolder: string?,
	SessionFileName: string?,
}

export type Client = {
	Rest: any,
	On: (self: Client, eventName: string, callback: (...any) -> ()) -> any,
	Once: (self: Client, eventName: string, callback: (...any) -> ()) -> any,
	Login: (self: Client) -> (),
	Destroy: (self: Client) -> (),
	SetPresence: (self: Client, presence: any) -> (),
}

local Client = {}
Client.__index = Client

function Client.new(options: ClientOptions): Client
	if type(options.Token) ~= "string" or options.Token == "" then
		error("Discord bot token must be a non-empty string", 2)
	end

	if type(options.Intents) ~= "number" then
		error("Client intents must be a number", 2)
	end

	local gateway = GatewayClient.new({
		Token = options.Token,
		Intents = options.Intents,
		Url = options.GatewayUrl,
		AutoReconnect = options.AutoReconnect,
		ReconnectDelay = options.ReconnectDelay,
		MaxReconnectAttempts = options.MaxReconnectAttempts,
		SessionPersistence = options.SessionPersistence,
		SessionFolder = options.SessionFolder,
		SessionFileName = options.SessionFileName,
	})

	local rest = RestClient.new({
		Token = options.Token,
		BaseUrl = options.RestBaseUrl,
	})

	local self = {
		Rest = rest,
		gateway = gateway,
	}

	local client = (setmetatable(self, Client) :: any) :: Client

	return client
end

function Client:On(eventName: string, callback: (...any) -> ()): any
	local state = self :: any

	if eventName == "MESSAGE_CREATE" then
		return state.gateway:On(eventName, function(rawMessage: any)
			callback(Message.new(rawMessage, state.Rest))
		end)
	end

	if eventName == "INTERACTION_CREATE" then
		return state.gateway:On(eventName, function(rawInteraction: any)
			callback(Interaction.new(rawInteraction, state.Rest))
		end)
	end

	return state.gateway:On(eventName, callback)
end

function Client:Once(eventName: string, callback: (...any) -> ()): any
	local state = self :: any

	if eventName == "MESSAGE_CREATE" then
		return state.gateway:Once(eventName, function(rawMessage: any)
			callback(Message.new(rawMessage, state.Rest))
		end)
	end

	if eventName == "INTERACTION_CREATE" then
		return state.gateway:Once(eventName, function(rawInteraction: any)
			callback(Interaction.new(rawInteraction, state.Rest))
		end)
	end

	return state.gateway:Once(eventName, callback)
end

function Client:Login(): ()
	(self :: any).gateway:Connect()
end

function Client:Destroy(): ()
	(self :: any).gateway:Disconnect()
end

function Client:SetPresence(presence: any): ()
	(self :: any).gateway:SetPresence(presence)
end

return Client
