--!strict

export type SlashCommandOption = {
	type: number,
	name: string,
	description: string,
	required: boolean?,
	choices: { any }?,
	options: { SlashCommandOption }?,
}

export type SlashCommandBuilder = {
	SetName: (self: SlashCommandBuilder, name: string) -> SlashCommandBuilder,
	SetDescription: (self: SlashCommandBuilder, description: string) -> SlashCommandBuilder,
	AddStringOption: (self: SlashCommandBuilder, name: string, description: string, required: boolean) -> SlashCommandBuilder,
	AddIntegerOption: (self: SlashCommandBuilder, name: string, description: string, required: boolean) -> SlashCommandBuilder,
	AddBooleanOption: (self: SlashCommandBuilder, name: string, description: string, required: boolean) -> SlashCommandBuilder,
	AddUserOption: (self: SlashCommandBuilder, name: string, description: string, required: boolean) -> SlashCommandBuilder,
	AddChannelOption: (self: SlashCommandBuilder, name: string, description: string, required: boolean) -> SlashCommandBuilder,
	AddRoleOption: (self: SlashCommandBuilder, name: string, description: string, required: boolean) -> SlashCommandBuilder,
	Build: (self: SlashCommandBuilder) -> { [string]: any },
}

local SlashCommandBuilder = {}
SlashCommandBuilder.__index = SlashCommandBuilder

local OptionType = {
	SubCommand = 1,
	SubCommandGroup = 2,
	String = 3,
	Integer = 4,
	Boolean = 5,
	User = 6,
	Channel = 7,
	Role = 8,
	Mentionable = 9,
	Number = 10,
	Attachment = 11,
}

local function assertCommandName(name: string): ()
	if type(name) ~= "string" or not string.match(name, "^[%l%d_-]+$") then
		error("slash command names must use lowercase letters, numbers, underscores, or dashes", 3)
	end

	if #name < 1 or #name > 32 then
		error("slash command names must be 1 to 32 characters", 3)
	end
end

local function assertDescription(description: string): ()
	if type(description) ~= "string" or #description < 1 or #description > 100 then
		error("slash command descriptions must be 1 to 100 characters", 3)
	end
end

local function addOption(self: SlashCommandBuilder, optionType: number, name: string, description: string, required: boolean): SlashCommandBuilder
	assertCommandName(name)
	assertDescription(description)

	if type(required) ~= "boolean" then
		error("required must be a boolean", 3)
	end

	local state = self :: any
	table.insert(state.command.options, {
		type = optionType,
		name = name,
		description = description,
		required = required,
	})

	return self
end

function SlashCommandBuilder.new(): SlashCommandBuilder
	local self = {
		command = {
			type = 1,
			name = nil :: string?,
			description = nil :: string?,
			options = {} :: { SlashCommandOption },
		},
	}

	return (setmetatable(self, SlashCommandBuilder) :: any) :: SlashCommandBuilder
end

function SlashCommandBuilder:SetName(name: string): SlashCommandBuilder
	assertCommandName(name)
	local state = self :: any
	state.command.name = name
	return self
end

function SlashCommandBuilder:SetDescription(description: string): SlashCommandBuilder
	assertDescription(description)
	local state = self :: any
	state.command.description = description
	return self
end

function SlashCommandBuilder:AddStringOption(name: string, description: string, required: boolean): SlashCommandBuilder
	return addOption(self, OptionType.String, name, description, required)
end

function SlashCommandBuilder:AddIntegerOption(name: string, description: string, required: boolean): SlashCommandBuilder
	return addOption(self, OptionType.Integer, name, description, required)
end

function SlashCommandBuilder:AddBooleanOption(name: string, description: string, required: boolean): SlashCommandBuilder
	return addOption(self, OptionType.Boolean, name, description, required)
end

function SlashCommandBuilder:AddUserOption(name: string, description: string, required: boolean): SlashCommandBuilder
	return addOption(self, OptionType.User, name, description, required)
end

function SlashCommandBuilder:AddChannelOption(name: string, description: string, required: boolean): SlashCommandBuilder
	return addOption(self, OptionType.Channel, name, description, required)
end

function SlashCommandBuilder:AddRoleOption(name: string, description: string, required: boolean): SlashCommandBuilder
	return addOption(self, OptionType.Role, name, description, required)
end

function SlashCommandBuilder:Build(): { [string]: any }
	local command = (self :: any).command
	if command.name == nil then
		error("slash command name is required", 2)
	end

	if command.description == nil then
		error("slash command description is required", 2)
	end

	local output: { [string]: any } = {
		type = command.type,
		name = command.name,
		description = command.description,
	}

	if #command.options > 0 then
		output.options = command.options
	end

	return output
end

return SlashCommandBuilder
