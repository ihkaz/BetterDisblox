--!strict

local Payload = {}

local MESSAGE_FLAG_EPHEMERAL = 64
local MESSAGE_FLAG_IS_COMPONENTS_V2 = 32768

local function copyTable(value: { [any]: any }): { [any]: any }
	local output: { [any]: any } = {}
	for key, tableValue in pairs(value) do
		output[key] = tableValue
	end

	return output
end

local function hasFlag(flags: number, flag: number): boolean
	return math.floor(flags / flag) % 2 == 1
end

local function addFlag(flags: number?, flag: number): number
	if flags == nil then
		return flag
	end

	if hasFlag(flags, flag) then
		return flags
	end

	return flags + flag
end

local function assertMessagePayload(payload: any): ()
	if type(payload.flags) == "number" and hasFlag(payload.flags, MESSAGE_FLAG_IS_COMPONENTS_V2) then
		if payload.content ~= nil then
			error("Components v2 payloads cannot include content; use TextDisplayBuilder instead", 3)
		end

		if payload.embeds ~= nil then
			error("Components v2 payloads cannot include embeds; use Components v2 builders instead", 3)
		end

		if payload.stickers ~= nil then
			error("Components v2 payloads cannot include stickers", 3)
		end

		if payload.poll ~= nil then
			error("Components v2 payloads cannot include poll", 3)
		end
	end
end

function Payload.Message(value: any): any
	if type(value) == "string" then
		return {
			content = value,
		}
	end

	if type(value) ~= "table" then
		error("message payload must be a string or table", 3)
	end

	local messagePayload = copyTable(value)
	assertMessagePayload(messagePayload)
	return messagePayload
end

function Payload.InteractionResponse(value: any): any
	local messagePayload = Payload.Message(value)

	return {
		type = 4,
		data = messagePayload,
	}
end

function Payload.DeferredInteractionResponse(ephemeral: boolean): any
	local data = nil

	if ephemeral then
		data = {
			flags = MESSAGE_FLAG_EPHEMERAL,
		}
	end

	return {
		type = 5,
		data = data,
	}
end

function Payload.DeferredUpdateInteractionResponse(): any
	return {
		type = 6,
	}
end

function Payload.UpdateInteractionResponse(value: any): any
	local messagePayload = Payload.Message(value)

	return {
		type = 7,
		data = messagePayload,
	}
end

function Payload.Modal(value: any): any
	local modalPayload = value
	if type(value) == "table" and type(value.Build) == "function" then
		modalPayload = value:Build()
	end

	if type(modalPayload) ~= "table" then
		error("modal payload must be a table or ModalBuilder", 3)
	end

	return {
		type = 9,
		data = modalPayload,
	}
end

function Payload.EphemeralMessage(value: any): any
	local messagePayload = Payload.Message(value)
	messagePayload.flags = addFlag(messagePayload.flags, MESSAGE_FLAG_EPHEMERAL)
	return messagePayload
end

function Payload.WithFlags(value: any, flags: number): any
	if type(flags) ~= "number" then
		error("flags must be a number", 2)
	end

	local messagePayload = Payload.Message(value)
	messagePayload.flags = flags
	assertMessagePayload(messagePayload)
	return messagePayload
end

return Payload
