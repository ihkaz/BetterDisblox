--!strict

local Http = require("./Http")
local Json = require("../util/Json")
local RateLimiter = require("./RateLimiter")

export type RestClientOptions = {
	Token: string,
	BaseUrl: string?,
}

export type RestClient = {
	Request: (self: RestClient, method: string, route: string, body: any) -> any,
	CreateMessage: (self: RestClient, channelId: string, payload: any) -> any,
	EditMessage: (self: RestClient, channelId: string, messageId: string, payload: any) -> any,
	DeleteMessage: (self: RestClient, channelId: string, messageId: string) -> any,
	CreateGlobalApplicationCommand: (self: RestClient, applicationId: string, payload: any) -> any,
	BulkOverwriteGlobalApplicationCommands: (self: RestClient, applicationId: string, payload: { any }) -> any,
	CreateGuildApplicationCommand: (self: RestClient, applicationId: string, guildId: string, payload: any) -> any,
	BulkOverwriteGuildApplicationCommands: (self: RestClient, applicationId: string, guildId: string, payload: { any }) -> any,
	CreateInteractionResponse: (self: RestClient, interactionId: string, interactionToken: string, payload: any) -> any,
	EditOriginalInteractionResponse: (self: RestClient, applicationId: string, interactionToken: string, payload: any) -> any,
	DeleteOriginalInteractionResponse: (self: RestClient, applicationId: string, interactionToken: string) -> any,
	CreateFollowupMessage: (self: RestClient, applicationId: string, interactionToken: string, payload: any) -> any,
}

local RestClient = {}
RestClient.__index = RestClient

local DEFAULT_BASE_URL = "https://discord.com/api/v10"

local function assertToken(token: string): ()
	if type(token) ~= "string" or token == "" then
		error("Discord bot token must be a non-empty string", 3)
	end
end

function RestClient.new(options: RestClientOptions): RestClient
	assertToken(options.Token)

	local baseUrl = options.BaseUrl
	if baseUrl == nil then
		baseUrl = DEFAULT_BASE_URL
	end

	local self = {
		token = options.Token,
		baseUrl = baseUrl,
		rateLimiter = RateLimiter.new(),
	}

	return (setmetatable(self, RestClient) :: any) :: RestClient
end

local function makeHeaders(token: string): { [string]: string }
	return {
		Authorization = "Bot " .. token,
		["User-Agent"] = "DiscordExecutorLuau/0.1",
	}
end

function RestClient:Request(method: string, route: string, body: any): any
	if type(method) ~= "string" or method == "" then
		error("method must be a non-empty string", 2)
	end

	if type(route) ~= "string" or route == "" then
		error("route must be a non-empty string", 2)
	end

	local state = self :: any
	local routeKey = method .. " " .. route
	state.rateLimiter:Wait(routeKey)

	local response = Http.JsonRequest(
		method,
		state.baseUrl .. route,
		makeHeaders(state.token),
		body
	)

	state.rateLimiter:Update(routeKey, response.StatusCode, response.Headers or {}, response.Body)

	if response.StatusCode == 204 then
		return nil
	end

	local decoded = nil
	if response.Body ~= "" then
		decoded = Json.Decode(response.Body)
	end

	if response.StatusCode < 200 or response.StatusCode >= 300 then
		error("Discord REST request failed: " .. method .. " " .. route .. " status=" .. tostring(response.StatusCode) .. " body=" .. response.Body, 2)
	end

	return decoded
end

function RestClient:CreateMessage(channelId: string, payload: any): any
	if type(channelId) ~= "string" or channelId == "" then
		error("channelId must be a non-empty string", 2)
	end

	return self:Request("POST", "/channels/" .. channelId .. "/messages", payload)
end

function RestClient:EditMessage(channelId: string, messageId: string, payload: any): any
	if type(channelId) ~= "string" or channelId == "" then
		error("channelId must be a non-empty string", 2)
	end

	if type(messageId) ~= "string" or messageId == "" then
		error("messageId must be a non-empty string", 2)
	end

	return self:Request("PATCH", "/channels/" .. channelId .. "/messages/" .. messageId, payload)
end

function RestClient:DeleteMessage(channelId: string, messageId: string): any
	if type(channelId) ~= "string" or channelId == "" then
		error("channelId must be a non-empty string", 2)
	end

	if type(messageId) ~= "string" or messageId == "" then
		error("messageId must be a non-empty string", 2)
	end

	return self:Request("DELETE", "/channels/" .. channelId .. "/messages/" .. messageId, nil)
end

function RestClient:CreateGlobalApplicationCommand(applicationId: string, payload: any): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	return self:Request("POST", "/applications/" .. applicationId .. "/commands", payload)
end

function RestClient:BulkOverwriteGlobalApplicationCommands(applicationId: string, payload: { any }): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(payload) ~= "table" then
		error("payload must be a table", 2)
	end

	return self:Request("PUT", "/applications/" .. applicationId .. "/commands", payload)
end

function RestClient:CreateGuildApplicationCommand(applicationId: string, guildId: string, payload: any): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(guildId) ~= "string" or guildId == "" then
		error("guildId must be a non-empty string", 2)
	end

	return self:Request("POST", "/applications/" .. applicationId .. "/guilds/" .. guildId .. "/commands", payload)
end

function RestClient:BulkOverwriteGuildApplicationCommands(applicationId: string, guildId: string, payload: { any }): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(guildId) ~= "string" or guildId == "" then
		error("guildId must be a non-empty string", 2)
	end

	if type(payload) ~= "table" then
		error("payload must be a table", 2)
	end

	return self:Request("PUT", "/applications/" .. applicationId .. "/guilds/" .. guildId .. "/commands", payload)
end

function RestClient:CreateInteractionResponse(interactionId: string, interactionToken: string, payload: any): any
	if type(interactionId) ~= "string" or interactionId == "" then
		error("interactionId must be a non-empty string", 2)
	end

	if type(interactionToken) ~= "string" or interactionToken == "" then
		error("interactionToken must be a non-empty string", 2)
	end

	return self:Request("POST", "/interactions/" .. interactionId .. "/" .. interactionToken .. "/callback", payload)
end

function RestClient:EditOriginalInteractionResponse(applicationId: string, interactionToken: string, payload: any): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(interactionToken) ~= "string" or interactionToken == "" then
		error("interactionToken must be a non-empty string", 2)
	end

	return self:Request("PATCH", "/webhooks/" .. applicationId .. "/" .. interactionToken .. "/messages/@original", payload)
end

function RestClient:DeleteOriginalInteractionResponse(applicationId: string, interactionToken: string): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(interactionToken) ~= "string" or interactionToken == "" then
		error("interactionToken must be a non-empty string", 2)
	end

	return self:Request("DELETE", "/webhooks/" .. applicationId .. "/" .. interactionToken .. "/messages/@original", nil)
end

function RestClient:CreateFollowupMessage(applicationId: string, interactionToken: string, payload: any): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(interactionToken) ~= "string" or interactionToken == "" then
		error("interactionToken must be a non-empty string", 2)
	end

	return self:Request("POST", "/webhooks/" .. applicationId .. "/" .. interactionToken, payload)
end

return RestClient
