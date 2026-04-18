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
	Values: { string },
	Options: { any },
	Raw: any,
	Deferred: boolean,
	Replied: boolean,
	Ephemeral: boolean,
	Reply: (self: Interaction, payload: any) -> any,
	reply: (self: Interaction, payload: any) -> any,
	ReplyEphemeral: (self: Interaction, payload: any) -> any,
	replyEphemeral: (self: Interaction, payload: any) -> any,
	DeferReply: (self: Interaction, ephemeral: boolean) -> any,
	deferReply: (self: Interaction, ephemeral: boolean) -> any,
	DeferUpdate: (self: Interaction) -> any,
	deferUpdate: (self: Interaction) -> any,
	EditReply: (self: Interaction, payload: any) -> any,
	editReply: (self: Interaction, payload: any) -> any,
	DeleteReply: (self: Interaction) -> any,
	deleteReply: (self: Interaction) -> any,
	FollowUp: (self: Interaction, payload: any) -> any,
	followUp: (self: Interaction, payload: any) -> any,
	ShowModal: (self: Interaction, modal: any) -> any,
	showModal: (self: Interaction, modal: any) -> any,
	Update: (self: Interaction, payload: any) -> any,
	update: (self: Interaction, payload: any) -> any,
	IsChatInputCommand: (self: Interaction) -> boolean,
	isChatInputCommand: (self: Interaction) -> boolean,
	IsMessageComponent: (self: Interaction) -> boolean,
	isMessageComponent: (self: Interaction) -> boolean,
	IsButton: (self: Interaction) -> boolean,
	isButton: (self: Interaction) -> boolean,
	IsStringSelectMenu: (self: Interaction) -> boolean,
	isStringSelectMenu: (self: Interaction) -> boolean,
	IsModalSubmit: (self: Interaction) -> boolean,
	isModalSubmit: (self: Interaction) -> boolean,
	GetOption: (self: Interaction, name: string) -> any,
	GetString: (self: Interaction, name: string) -> string?,
	GetInteger: (self: Interaction, name: string) -> number?,
	GetBoolean: (self: Interaction, name: string) -> boolean?,
	GetTextInputValue: (self: Interaction, customId: string) -> string?,
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

	local values = {}
	if type(rawInteraction.data) == "table" and type(rawInteraction.data.values) == "table" then
		values = rawInteraction.data.values
	end

	local self = {
		Id = rawInteraction.id,
		Token = rawInteraction.token,
		ApplicationId = rawInteraction.application_id,
		Type = rawInteraction.type,
		Data = rawInteraction.data,
		CommandName = commandName,
		CustomId = customId,
		Values = values,
		Options = getOptions(rawInteraction),
		Raw = rawInteraction,
		Deferred = false,
		Replied = false,
		Ephemeral = false,
		restClient = restClient,
	}

	return (setmetatable(self, Interaction) :: any) :: Interaction
end

function Interaction:Reply(payload: any): any
	local state = self :: any
	local response = state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.InteractionResponse(payload)
	)
	state.Replied = true
	return response
end

function Interaction:ReplyEphemeral(payload: any): any
	local state = self :: any
	local response = state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.InteractionResponse(Payload.EphemeralMessage(payload))
	)
	state.Replied = true
	state.Ephemeral = true
	return response
end

function Interaction:DeferReply(ephemeral: boolean): any
	local state = self :: any
	local response = state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.DeferredInteractionResponse(ephemeral)
	)
	state.Deferred = true
	state.Ephemeral = ephemeral
	return response
end

function Interaction:DeferUpdate(): any
	if not self:IsMessageComponent() then
		error("DeferUpdate can only be used with message component interactions", 2)
	end

	local state = self :: any
	local response = state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.DeferredUpdateInteractionResponse()
	)
	state.Deferred = true
	return response
end

function Interaction:EditReply(payload: any): any
	local state = self :: any
	local response = state.restClient:EditOriginalInteractionResponse(
		state.ApplicationId,
		state.Token,
		Payload.Message(payload)
	)
	state.Replied = true
	return response
end

function Interaction:DeleteReply(): any
	local state = self :: any
	return state.restClient:DeleteOriginalInteractionResponse(state.ApplicationId, state.Token)
end

function Interaction:FollowUp(payload: any): any
	local state = self :: any
	local response = state.restClient:CreateFollowupMessage(
		state.ApplicationId,
		state.Token,
		Payload.Message(payload)
	)
	state.Replied = true
	return response
end

function Interaction:ShowModal(modal: any): any
	local state = self :: any
	local response = state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.Modal(modal)
	)
	state.Replied = true
	return response
end

function Interaction:Update(payload: any): any
	if not self:IsMessageComponent() then
		error("Update can only be used with message component interactions", 2)
	end

	local state = self :: any
	local response = state.restClient:CreateInteractionResponse(
		state.Id,
		state.Token,
		Payload.UpdateInteractionResponse(payload)
	)
	state.Replied = true
	return response
end

function Interaction:IsChatInputCommand(): boolean
	return (self :: any).Type == 2
end

function Interaction:IsMessageComponent(): boolean
	return (self :: any).Type == 3
end

function Interaction:IsButton(): boolean
	local data = (self :: any).Data
	return self:IsMessageComponent() and type(data) == "table" and data.component_type == 2
end

function Interaction:IsStringSelectMenu(): boolean
	local data = (self :: any).Data
	return self:IsMessageComponent() and type(data) == "table" and data.component_type == 3
end

function Interaction:IsModalSubmit(): boolean
	return (self :: any).Type == 5
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

function Interaction:GetTextInputValue(customId: string): string?
	if type(customId) ~= "string" or customId == "" then
		error("customId must be a non-empty string", 2)
	end

	local data = (self :: any).Data
	if type(data) ~= "table" or type(data.components) ~= "table" then
		return nil
	end

	local function findValue(component: any): string?
		if type(component) ~= "table" then
			return nil
		end

		if component.custom_id == customId and type(component.value) == "string" then
			return component.value
		end

		if type(component.component) == "table" then
			local childValue = findValue(component.component)
			if childValue ~= nil then
				return childValue
			end
		end

		if type(component.components) == "table" then
			for _, child in ipairs(component.components) do
				local childValue = findValue(child)
				if childValue ~= nil then
					return childValue
				end
			end
		end

		return nil
	end

	for _, component in ipairs(data.components) do
		local value = findValue(component)
		if value ~= nil then
			return value
		end
	end

	return nil
end

Interaction.reply = Interaction.Reply
Interaction.replyEphemeral = Interaction.ReplyEphemeral
Interaction.deferReply = Interaction.DeferReply
Interaction.deferUpdate = Interaction.DeferUpdate
Interaction.editReply = Interaction.EditReply
Interaction.deleteReply = Interaction.DeleteReply
Interaction.followUp = Interaction.FollowUp
Interaction.showModal = Interaction.ShowModal
Interaction.update = Interaction.Update
Interaction.isChatInputCommand = Interaction.IsChatInputCommand
Interaction.isMessageComponent = Interaction.IsMessageComponent
Interaction.isButton = Interaction.IsButton
Interaction.isStringSelectMenu = Interaction.IsStringSelectMenu
Interaction.isModalSubmit = Interaction.IsModalSubmit

return Interaction
