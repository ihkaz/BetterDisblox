--!strict

export type StringSelectMenuBuilder = {
	SetCustomId: (self: StringSelectMenuBuilder, customId: string) -> StringSelectMenuBuilder,
	SetPlaceholder: (self: StringSelectMenuBuilder, placeholder: string) -> StringSelectMenuBuilder,
	SetMinValues: (self: StringSelectMenuBuilder, minValues: number) -> StringSelectMenuBuilder,
	SetMaxValues: (self: StringSelectMenuBuilder, maxValues: number) -> StringSelectMenuBuilder,
	SetDisabled: (self: StringSelectMenuBuilder, disabled: boolean) -> StringSelectMenuBuilder,
	AddOptions: (self: StringSelectMenuBuilder, ...any) -> StringSelectMenuBuilder,
	SetOptions: (self: StringSelectMenuBuilder, options: { any }) -> StringSelectMenuBuilder,
	Build: (self: StringSelectMenuBuilder) -> { [string]: any },
}

local StringSelectMenuBuilder = {}
StringSelectMenuBuilder.__index = StringSelectMenuBuilder

local COMPONENT_TYPE_STRING_SELECT = 3
local MAX_OPTIONS = 25

local function assertString(name: string, value: string, maxLength: number): ()
	if type(value) ~= "string" or value == "" then
		error(name .. " must be a non-empty string", 3)
	end

	if #value > maxLength then
		error(name .. " must be " .. tostring(maxLength) .. " characters or fewer", 3)
	end
end

local function normalizeOption(option: any): any
	if type(option) ~= "table" then
		error("select menu option must be a table", 3)
	end

	if type(option.Build) == "function" then
		return option:Build()
	end

	return option
end

function StringSelectMenuBuilder.new(): StringSelectMenuBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_STRING_SELECT,
			options = {} :: { any },
		} :: { [string]: any },
	}

	return (setmetatable(self, StringSelectMenuBuilder) :: any) :: StringSelectMenuBuilder
end

function StringSelectMenuBuilder:SetCustomId(customId: string): StringSelectMenuBuilder
	assertString("customId", customId, 100)
	local component = (self :: any).component
	component.custom_id = customId
	return self
end

function StringSelectMenuBuilder:SetPlaceholder(placeholder: string): StringSelectMenuBuilder
	assertString("placeholder", placeholder, 150)
	local component = (self :: any).component
	component.placeholder = placeholder
	return self
end

function StringSelectMenuBuilder:SetMinValues(minValues: number): StringSelectMenuBuilder
	if type(minValues) ~= "number" or minValues < 0 or minValues > 25 then
		error("minValues must be a number from 0 to 25", 2)
	end

	local component = (self :: any).component
	component.min_values = minValues
	return self
end

function StringSelectMenuBuilder:SetMaxValues(maxValues: number): StringSelectMenuBuilder
	if type(maxValues) ~= "number" or maxValues < 1 or maxValues > 25 then
		error("maxValues must be a number from 1 to 25", 2)
	end

	local component = (self :: any).component
	component.max_values = maxValues
	return self
end

function StringSelectMenuBuilder:SetDisabled(disabled: boolean): StringSelectMenuBuilder
	if type(disabled) ~= "boolean" then
		error("disabled must be a boolean", 2)
	end

	local component = (self :: any).component
	component.disabled = disabled
	return self
end

function StringSelectMenuBuilder:AddOptions(...: any): StringSelectMenuBuilder
	local component = (self :: any).component
	local options = table.pack(...)

	for index = 1, options.n do
		if #component.options >= MAX_OPTIONS then
			error("string select menus can contain at most 25 options", 2)
		end

		table.insert(component.options, normalizeOption(options[index]))
	end

	return self
end

function StringSelectMenuBuilder:SetOptions(options: { any }): StringSelectMenuBuilder
	if type(options) ~= "table" then
		error("options must be a table", 2)
	end

	if #options > MAX_OPTIONS then
		error("string select menus can contain at most 25 options", 2)
	end

	local normalizedOptions: { any } = {}
	for _, option in ipairs(options) do
		table.insert(normalizedOptions, normalizeOption(option))
	end

	local component = (self :: any).component
	component.options = normalizedOptions
	return self
end

function StringSelectMenuBuilder:Build(): { [string]: any }
	local component = (self :: any).component

	if type(component.custom_id) ~= "string" or component.custom_id == "" then
		error("string select menus require a customId", 2)
	end

	if #component.options < 1 then
		error("string select menus require at least one option", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return StringSelectMenuBuilder
