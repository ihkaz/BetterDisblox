--!strict

local Payload = {}

function Payload.Message(value: any): any
	if type(value) == "string" then
		return {
			content = value,
		}
	end

	if type(value) ~= "table" then
		error("message payload must be a string or table", 3)
	end

	return value
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
			flags = 64,
		}
	end

	return {
		type = 5,
		data = data,
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
	messagePayload.flags = 64
	return messagePayload
end

function Payload.WithFlags(value: any, flags: number): any
	local messagePayload = Payload.Message(value)
	messagePayload.flags = flags
	return messagePayload
end

return Payload
