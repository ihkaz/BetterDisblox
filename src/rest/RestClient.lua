--!strict

local Http = require("./Http")
local Json = require("../util/Json")
local Payload = require("../structures/Payload")
local RateLimiter = require("./RateLimiter")

export type RestClientOptions = {
	Token: string,
	BaseUrl: string?,
}

export type RestClient = {
	Request: (self: RestClient, method: string, route: string, body: any) -> any,
	GetCurrentUser: (self: RestClient) -> any,
	GetUser: (self: RestClient, userId: string) -> any,
	GetChannel: (self: RestClient, channelId: string) -> any,
	ModifyChannel: (self: RestClient, channelId: string, payload: any) -> any,
	GetChannelMessages: (self: RestClient, channelId: string, options: { [string]: any }?) -> any,
	GetMessage: (self: RestClient, channelId: string, messageId: string) -> any,
	CreateMessage: (self: RestClient, channelId: string, payload: any) -> any,
	EditMessage: (self: RestClient, channelId: string, messageId: string, payload: any) -> any,
	DeleteMessage: (self: RestClient, channelId: string, messageId: string) -> any,
	TriggerTyping: (self: RestClient, channelId: string) -> any,
	GetGuild: (self: RestClient, guildId: string) -> any,
	GetGuildChannels: (self: RestClient, guildId: string) -> any,
	GetGuildMember: (self: RestClient, guildId: string, userId: string) -> any,
	GetGuildRoles: (self: RestClient, guildId: string) -> any,
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

local function assertNonEmptyString(name: string, value: string): ()
	if type(value) ~= "string" or value == "" then
		error(name .. " must be a non-empty string", 3)
	end
end

local function normalizeBuildable(value: any): any
	if type(value) == "table" and type(value.Build) == "function" then
		return value:Build()
	end

	return value
end

local function normalizeCommandPayload(payload: any): any
	if type(payload) ~= "table" then
		error("command payload must be a table or builder", 3)
	end

	return normalizeBuildable(payload)
end

local function normalizeCommandList(payload: { any }): { any }
	if type(payload) ~= "table" then
		error("payload must be a table", 3)
	end

	local commands: { any } = {}
	for _, command in ipairs(payload) do
		table.insert(commands, normalizeCommandPayload(command))
	end

	return commands
end

local function appendQuery(route: string, options: { [string]: any }?): string
	if options == nil then
		return route
	end

	local params: { string } = {}
	for key, value in pairs(options) do
		table.insert(params, tostring(key) .. "=" .. game:GetService("HttpService"):UrlEncode(tostring(value)))
	end

	if #params == 0 then
		return route
	end

	return route .. "?" .. table.concat(params, "&")
end

function RestClient:GetCurrentUser(): any
	return self:Request("GET", "/users/@me", nil)
end

function RestClient:GetUser(userId: string): any
	assertNonEmptyString("userId", userId)
	return self:Request("GET", "/users/" .. userId, nil)
end

function RestClient:GetChannel(channelId: string): any
	assertNonEmptyString("channelId", channelId)
	return self:Request("GET", "/channels/" .. channelId, nil)
end

function RestClient:ModifyChannel(channelId: string, payload: any): any
	assertNonEmptyString("channelId", channelId)
	return self:Request("PATCH", "/channels/" .. channelId, payload)
end

function RestClient:GetChannelMessages(channelId: string, options: { [string]: any }?): any
	assertNonEmptyString("channelId", channelId)
	return self:Request("GET", appendQuery("/channels/" .. channelId .. "/messages", options), nil)
end

function RestClient:GetMessage(channelId: string, messageId: string): any
	assertNonEmptyString("channelId", channelId)
	assertNonEmptyString("messageId", messageId)
	return self:Request("GET", "/channels/" .. channelId .. "/messages/" .. messageId, nil)
end

function RestClient:CreateMessage(channelId: string, payload: any): any
	if type(channelId) ~= "string" or channelId == "" then
		error("channelId must be a non-empty string", 2)
	end

	return self:Request("POST", "/channels/" .. channelId .. "/messages", Payload.Message(payload))
end

function RestClient:EditMessage(channelId: string, messageId: string, payload: any): any
	if type(channelId) ~= "string" or channelId == "" then
		error("channelId must be a non-empty string", 2)
	end

	if type(messageId) ~= "string" or messageId == "" then
		error("messageId must be a non-empty string", 2)
	end

	return self:Request("PATCH", "/channels/" .. channelId .. "/messages/" .. messageId, Payload.Message(payload))
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

function RestClient:TriggerTyping(channelId: string): any
	assertNonEmptyString("channelId", channelId)
	return self:Request("POST", "/channels/" .. channelId .. "/typing", nil)
end

function RestClient:GetGuild(guildId: string): any
	assertNonEmptyString("guildId", guildId)
	return self:Request("GET", "/guilds/" .. guildId, nil)
end

function RestClient:GetGuildChannels(guildId: string): any
	assertNonEmptyString("guildId", guildId)
	return self:Request("GET", "/guilds/" .. guildId .. "/channels", nil)
end

function RestClient:GetGuildMember(guildId: string, userId: string): any
	assertNonEmptyString("guildId", guildId)
	assertNonEmptyString("userId", userId)
	return self:Request("GET", "/guilds/" .. guildId .. "/members/" .. userId, nil)
end

function RestClient:GetGuildRoles(guildId: string): any
	assertNonEmptyString("guildId", guildId)
	return self:Request("GET", "/guilds/" .. guildId .. "/roles", nil)
end

function RestClient:CreateGlobalApplicationCommand(applicationId: string, payload: any): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	return self:Request("POST", "/applications/" .. applicationId .. "/commands", normalizeCommandPayload(payload))
end

function RestClient:BulkOverwriteGlobalApplicationCommands(applicationId: string, payload: { any }): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	return self:Request("PUT", "/applications/" .. applicationId .. "/commands", normalizeCommandList(payload))
end

function RestClient:CreateGuildApplicationCommand(applicationId: string, guildId: string, payload: any): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(guildId) ~= "string" or guildId == "" then
		error("guildId must be a non-empty string", 2)
	end

	return self:Request("POST", "/applications/" .. applicationId .. "/guilds/" .. guildId .. "/commands", normalizeCommandPayload(payload))
end

function RestClient:BulkOverwriteGuildApplicationCommands(applicationId: string, guildId: string, payload: { any }): any
	if type(applicationId) ~= "string" or applicationId == "" then
		error("applicationId must be a non-empty string", 2)
	end

	if type(guildId) ~= "string" or guildId == "" then
		error("guildId must be a non-empty string", 2)
	end

	return self:Request("PUT", "/applications/" .. applicationId .. "/guilds/" .. guildId .. "/commands", normalizeCommandList(payload))
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
