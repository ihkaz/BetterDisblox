--!strict

local Http = require("../rest/Http")
local Payload = require("../structures/Payload")

export type WebhookClientOptions = {
	Wait: boolean?,
}

export type WebhookClient = {
	Send: (self: WebhookClient, payload: any) -> any,
	EditMessage: (self: WebhookClient, messageId: string, payload: any) -> any,
	DeleteMessage: (self: WebhookClient, messageId: string) -> any,
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
	}

	return (setmetatable(self, WebhookClient) :: any) :: WebhookClient
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

function WebhookClient:Send(payload: any): any
	local state = self :: any
	local url = state.baseUrl

	if state.waitForResponse then
		url ..= "?wait=true"
	end

	return requestJson("POST", url, Payload.Message(payload))
end

function WebhookClient:EditMessage(messageId: string, payload: any): any
	if type(messageId) ~= "string" or messageId == "" then
		error("messageId must be a non-empty string", 2)
	end

	local state = self :: any
	return requestJson("PATCH", state.baseUrl .. "/messages/" .. messageId, Payload.Message(payload))
end

function WebhookClient:DeleteMessage(messageId: string): any
	if type(messageId) ~= "string" or messageId == "" then
		error("messageId must be a non-empty string", 2)
	end

	local state = self :: any
	return requestJson("DELETE", state.baseUrl .. "/messages/" .. messageId, nil)
end

return WebhookClient
