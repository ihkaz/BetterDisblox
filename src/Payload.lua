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

function Payload.EphemeralMessage(value: any): any
	local messagePayload = Payload.Message(value)
	messagePayload.flags = 64
	return messagePayload
end

return Payload
