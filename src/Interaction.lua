--!strict

local Payload = require("./Payload")

export type Interaction = {
	Id: string,
	Token: string,
	ApplicationId: string,
	Type: number,
	Data: any,
	CommandName: string?,
	CustomId: string?,
	Options: { any },
	Raw: any,
	Reply: (self: Interaction, payload: any) -> any,
	ReplyEphemeral: (self: Interaction, payload: any) -> any,
	DeferReply: (self: Interaction, ephemeral: boolean) -> any,
	EditReply: (self: Interaction, payload: any) -> any,
	DeleteReply: (self: Interaction) -> any,
	FollowUp: (self: Interaction, payload: any) -> any,
	GetOption: (self: Interaction, name: string) -> any,
	GetString: (self: Interaction, name: string) -> string?,
	GetInteger: (self: Interaction, name: string) -> number?,
	GetBoolean: (self: Interaction, name: string) -> boolean?,
}

local Interaction = {}
Interaction.__index = Interaction

local function getOptions(rawInteraction: any): { any }
	if type(rawInteraction.data) ~= "table" or type(rawInteraction.data.options) ~= "table" then
		return {}
	end

	return rawInteraction.data.options
end

function Interaction.new(rawInteraction: any, restClient: any): Interaction
	if type(rawInteraction) ~= "table" then
		error("rawInteraction must be a table", 2)
	end

	if type(restClient) ~= "table" then
		error("restClient must be a table", 2)
	end

	local commandName = nil
	if type(rawInteraction.data) == "table" then
		commandName = rawInteraction.data.name
	end

	local customId = nil
	if type(rawInteraction.data) == "table" then
		customId = rawInteraction.data.custom_id
	end

	local self = {
		Id = rawInteraction.id,
		Token = rawInteraction.token,
		ApplicationId = rawInteraction.application_id,
		Type = rawInteraction.type,
		Data = rawInteraction.data,
		CommandName = commandName,
		CustomId = customId,
		Options = getOptions(rawInteraction),
		Raw = rawInteraction,
		restClient = restClient,
	}

	return (setmetatable(self, Interaction) :: any) :: Interaction
end

function Interaction:Reply(payload: any): any
	local state = self :: any
	return state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.InteractionResponse(payload)
	)
end

function Interaction:ReplyEphemeral(payload: any): any
	local state = self :: any
	return state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.InteractionResponse(Payload.EphemeralMessage(payload))
	)
end

function Interaction:DeferReply(ephemeral: boolean): any
	local state = self :: any
	return state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.DeferredInteractionResponse(ephemeral)
	)
end

function Interaction:EditReply(payload: any): any
	local state = self :: any
	return state.restClient:EditOriginalInteractionResponse(
		state.ApplicationId,
		state.Token,
		Payload.Message(payload)
	)
end

function Interaction:DeleteReply(): any
	local state = self :: any
	return state.restClient:DeleteOriginalInteractionResponse(state.ApplicationId, state.Token)
end

function Interaction:FollowUp(payload: any): any
	local state = self :: any
	return state.restClient:CreateFollowupMessage(
		state.ApplicationId,
		state.Token,
		Payload.Message(payload)
	)
end

function Interaction:GetOption(name: string): any
	if type(name) ~= "string" or name == "" then
		error("option name must be a non-empty string", 2)
	end

	for _, option in ipairs((self :: any).Options) do
		if option.name == name then
			return option
		end
	end

	return nil
end

function Interaction:GetString(name: string): string?
	local option = self:GetOption(name)
	if option == nil then
		return nil
	end

	return option.value
end

function Interaction:GetInteger(name: string): number?
	local option = self:GetOption(name)
	if option == nil then
		return nil
	end

	return option.value
end

function Interaction:GetBoolean(name: string): boolean?
	local option = self:GetOption(name)
	if option == nil then
		return nil
	end

	return option.value
end

return Interaction
