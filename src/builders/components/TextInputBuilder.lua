--!strict

export type TextInputBuilder = {
	SetCustomId: (self: TextInputBuilder, customId: string) -> TextInputBuilder,
	SetLabel: (self: TextInputBuilder, label: string) -> TextInputBuilder,
	SetStyle: (self: TextInputBuilder, style: number) -> TextInputBuilder,
	SetMinLength: (self: TextInputBuilder, minLength: number) -> TextInputBuilder,
	SetMaxLength: (self: TextInputBuilder, maxLength: number) -> TextInputBuilder,
	SetRequired: (self: TextInputBuilder, required: boolean) -> TextInputBuilder,
	SetValue: (self: TextInputBuilder, value: string) -> TextInputBuilder,
	SetPlaceholder: (self: TextInputBuilder, placeholder: string) -> TextInputBuilder,
	Build: (self: TextInputBuilder) -> { [string]: any },
}

local TextInputBuilder = {}
TextInputBuilder.__index = TextInputBuilder

local COMPONENT_TYPE_TEXT_INPUT = 4

local function assertString(name: string, value: string, maxLength: number): ()
	if type(value) ~= "string" or value == "" then
		error(name .. " must be a non-empty string", 3)
	end

	if #value > maxLength then
		error(name .. " must be " .. tostring(maxLength) .. " characters or fewer", 3)
	end
end

function TextInputBuilder.new(): TextInputBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_TEXT_INPUT,
		} :: { [string]: any },
	}

	return (setmetatable(self, TextInputBuilder) :: any) :: TextInputBuilder
end

function TextInputBuilder:SetCustomId(customId: string): TextInputBuilder
	assertString("customId", customId, 100)
	local component = (self :: any).component
	component.custom_id = customId
	return self
end

function TextInputBuilder:SetLabel(label: string): TextInputBuilder
	assertString("label", label, 45)
	local component = (self :: any).component
	component.label = label
	return self
end

function TextInputBuilder:SetStyle(style: number): TextInputBuilder
	if type(style) ~= "number" or (style ~= 1 and style ~= 2) then
		error("text input style must be 1 or 2", 2)
	end

	local component = (self :: any).component
	component.style = style
	return self
end

function TextInputBuilder:SetMinLength(minLength: number): TextInputBuilder
	if type(minLength) ~= "number" or minLength < 0 or minLength > 4000 then
		error("minLength must be a number from 0 to 4000", 2)
	end

	local component = (self :: any).component
	component.min_length = minLength
	return self
end

function TextInputBuilder:SetMaxLength(maxLength: number): TextInputBuilder
	if type(maxLength) ~= "number" or maxLength < 1 or maxLength > 4000 then
		error("maxLength must be a number from 1 to 4000", 2)
	end

	local component = (self :: any).component
	component.max_length = maxLength
	return self
end

function TextInputBuilder:SetRequired(required: boolean): TextInputBuilder
	if type(required) ~= "boolean" then
		error("required must be a boolean", 2)
	end

	local component = (self :: any).component
	component.required = required
	return self
end

function TextInputBuilder:SetValue(value: string): TextInputBuilder
	assertString("value", value, 4000)
	local component = (self :: any).component
	component.value = value
	return self
end

function TextInputBuilder:SetPlaceholder(placeholder: string): TextInputBuilder
	assertString("placeholder", placeholder, 100)
	local component = (self :: any).component
	component.placeholder = placeholder
	return self
end

function TextInputBuilder:Build(): { [string]: any }
	local component = (self :: any).component

	if type(component.custom_id) ~= "string" or component.custom_id == "" then
		error("text inputs require a customId", 2)
	end

	if type(component.label) ~= "string" or component.label == "" then
		error("text inputs require a label", 2)
	end

	if type(component.style) ~= "number" then
		error("text inputs require a style", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return TextInputBuilder
