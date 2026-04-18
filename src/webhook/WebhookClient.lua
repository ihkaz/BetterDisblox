--!strict

local Http = require("../rest/Http")
local Payload = require("../structures/Payload")

export type WebhookClientOptions = {
	Wait: boolean?,
	Username: string?,
	AvatarUrl: string?,
	ThreadId: string?,
}

export type WebhookClient = {
	Send: (self: WebhookClient, payload: any, options: WebhookClientOptions?) -> any,
	EditMessage: (self: WebhookClient, messageId: string, payload: any, options: WebhookClientOptions?) -> any,
	DeleteMessage: (self: WebhookClient, messageId: string, options: WebhookClientOptions?) -> any,
}

local WebhookClient = {}
WebhookClient.__index = WebhookClient

local function parseWebhookUrl(url: string): (string, string, string)
	if type(url) ~= "string" or url == "" then
		error("webhook url must be a non-empty string", 3)
	end

	local webhookId, webhookToken = string.match(url, "discord%.com/api/webhooks/([^/]+)/([^/?#]+)")
	if webhookId == nil or webhookToken == nil then
		webhookId, webhookToken = string.match(url, "discordapp%.com/api/webhooks/([^/]+)/([^/?#]+)")
	end

	if webhookId == nil or webhookToken == nil then
		error("invalid Discord webhook url", 3)
	end

	local baseUrl = "https://discord.com/api/webhooks/" .. webhookId .. "/" .. webhookToken
	return baseUrl, webhookId, webhookToken
end

function WebhookClient.new(url: string, options: WebhookClientOptions?): WebhookClient
	local baseUrl, webhookId, webhookToken = parseWebhookUrl(url)
	local waitForResponse = false

	if options ~= nil and options.Wait == true then
		waitForResponse = true
	end

	local self = {
		baseUrl = baseUrl,
		webhookId = webhookId,
		webhookToken = webhookToken,
		waitForResponse = waitForResponse,
		username = options and options.Username or nil,
		avatarUrl = options and options.AvatarUrl or nil,
		threadId = options and options.ThreadId or nil,
	}

	return (setmetatable(self, WebhookClient) :: any) :: WebhookClient
end

local function appendQuery(url: string, key: string, value: string): string
	local separator = "?"
	if string.find(url, "?", 1, true) ~= nil then
		separator = "&"
	end

	return url .. separator .. key .. "=" .. game:GetService("HttpService"):UrlEncode(value)
end

local function applyWebhookPayloadDefaults(payload: any, state: any, options: WebhookClientOptions?): any
	local resolvedPayload = Payload.Message(payload)
	local messagePayload = {}
	for key, value in pairs(resolvedPayload) do
		messagePayload[key] = value
	end

	local username = state.username
	local avatarUrl = state.avatarUrl

	if options ~= nil then
		if options.Username ~= nil then
			username = options.Username
		end

		if options.AvatarUrl ~= nil then
			avatarUrl = options.AvatarUrl
		end
	end

	if username ~= nil then
		messagePayload.username = username
	end

	if avatarUrl ~= nil then
		messagePayload.avatar_url = avatarUrl
	end

	return messagePayload
end

local function applyWebhookQuery(url: string, state: any, options: WebhookClientOptions?): string
	local threadId = state.threadId
	if options ~= nil and options.ThreadId ~= nil then
		threadId = options.ThreadId
	end

	if threadId ~= nil then
		url = appendQuery(url, "thread_id", threadId)
	end

	return url
end

local function requestJson(method: string, url: string, payload: any): any
	local response = Http.JsonRequest(method, url, {}, payload)

	if response.StatusCode == 204 then
		return nil
	end

	if response.StatusCode < 200 or response.StatusCode >= 300 then
		error("Discord webhook request failed: " .. method .. " " .. url .. " status=" .. tostring(response.StatusCode) .. " body=" .. response.Body, 3)
	end

	if response.Body == "" then
		return nil
	end

	return game:GetService("HttpService"):JSONDecode(response.Body)
end

function WebhookClient:Send(payload: any, options: WebhookClientOptions?): any
	local state = self :: any
	local url = state.baseUrl

	if state.waitForResponse or (options ~= nil and options.Wait == true) then
		url = appendQuery(url, "wait", "true")
	end

	url = applyWebhookQuery(url, state, options)
	return requestJson("POST", url, applyWebhookPayloadDefaults(payload, state, options))
end

function WebhookClient:EditMessage(messageId: string, payload: any, options: WebhookClientOptions?): any
	if type(messageId) ~= "string" or messageId == "" then
		error("messageId must be a non-empty string", 2)
	end

	local state = self :: any
	local url = applyWebhookQuery(state.baseUrl .. "/messages/" .. messageId, state, options)
	return requestJson("PATCH", url, applyWebhookPayloadDefaults(payload, state, options))
end

function WebhookClient:DeleteMessage(messageId: string, options: WebhookClientOptions?): any
	if type(messageId) ~= "string" or messageId == "" then
		error("messageId must be a non-empty string", 2)
	end

	local state = self :: any
	local url = applyWebhookQuery(state.baseUrl .. "/messages/" .. messageId, state, options)
	return requestJson("DELETE", url, nil)
end

return WebhookClient
