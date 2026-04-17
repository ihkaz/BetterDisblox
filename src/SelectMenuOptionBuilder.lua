--!strict

export type SelectMenuOptionBuilder = {
	SetLabel: (self: SelectMenuOptionBuilder, label: string) -> SelectMenuOptionBuilder,
	SetValue: (self: SelectMenuOptionBuilder, value: string) -> SelectMenuOptionBuilder,
	SetDescription: (self: SelectMenuOptionBuilder, description: string) -> SelectMenuOptionBuilder,
	SetDefault: (self: SelectMenuOptionBuilder, defaultValue: boolean) -> SelectMenuOptionBuilder,
	Build: (self: SelectMenuOptionBuilder) -> { [string]: any },
}

local SelectMenuOptionBuilder = {}
SelectMenuOptionBuilder.__index = SelectMenuOptionBuilder

local function assertString(name: string, value: string, maxLength: number): ()
	if type(value) ~= "string" or value == "" then
		error(name .. " must be a non-empty string", 3)
	end

	if #value > maxLength then
		error(name .. " must be " .. tostring(maxLength) .. " characters or fewer", 3)
	end
end

function SelectMenuOptionBuilder.new(): SelectMenuOptionBuilder
	local self = {
		option = {} :: { [string]: any },
	}

	return (setmetatable(self, SelectMenuOptionBuilder) :: any) :: SelectMenuOptionBuilder
end

function SelectMenuOptionBuilder:SetLabel(label: string): SelectMenuOptionBuilder
	assertString("label", label, 100)
	local state = self :: any
	state.option.label = label
	return self
end

function SelectMenuOptionBuilder:SetValue(value: string): SelectMenuOptionBuilder
	assertString("value", value, 100)
	local state = self :: any
	state.option.value = value
	return self
end

function SelectMenuOptionBuilder:SetDescription(description: string): SelectMenuOptionBuilder
	assertString("description", description, 100)
	local state = self :: any
	state.option.description = description
	return self
end

function SelectMenuOptionBuilder:SetDefault(defaultValue: boolean): SelectMenuOptionBuilder
	if type(defaultValue) ~= "boolean" then
		error("defaultValue must be a boolean", 2)
	end

	local state = self :: any
	state.option.default = defaultValue
	return self
end

function SelectMenuOptionBuilder:Build(): { [string]: any }
	local option = (self :: any).option

	if type(option.label) ~= "string" or option.label == "" then
		error("select menu option label is required", 2)
	end

	if type(option.value) ~= "string" or option.value == "" then
		error("select menu option value is required", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(option) do
		output[key] = value
	end

	return output
end

return SelectMenuOptionBuilder
