--!strict

export type ButtonBuilder = {
	SetCustomId: (self: ButtonBuilder, customId: string) -> ButtonBuilder,
	SetLabel: (self: ButtonBuilder, label: string) -> ButtonBuilder,
	SetStyle: (self: ButtonBuilder, style: number) -> ButtonBuilder,
	SetUrl: (self: ButtonBuilder, url: string) -> ButtonBuilder,
	SetDisabled: (self: ButtonBuilder, disabled: boolean) -> ButtonBuilder,
	Build: (self: ButtonBuilder) -> { [string]: any },
}

local ButtonBuilder = {}
ButtonBuilder.__index = ButtonBuilder

local COMPONENT_TYPE_BUTTON = 2
local LINK_BUTTON_STYLE = 5

local function assertString(name: string, value: string, maxLength: number): ()
	if type(value) ~= "string" or value == "" then
		error(name .. " must be a non-empty string", 3)
	end

	if #value > maxLength then
		error(name .. " must be " .. tostring(maxLength) .. " characters or fewer", 3)
	end
end

function ButtonBuilder.new(): ButtonBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_BUTTON,
		} :: { [string]: any },
	}

	return (setmetatable(self, ButtonBuilder) :: any) :: ButtonBuilder
end

function ButtonBuilder:SetCustomId(customId: string): ButtonBuilder
	assertString("customId", customId, 100)

	local component = (self :: any).component
	component.custom_id = customId
	component.url = nil
	return self
end

function ButtonBuilder:SetLabel(label: string): ButtonBuilder
	assertString("label", label, 80)

	local component = (self :: any).component
	component.label = label
	return self
end

function ButtonBuilder:SetStyle(style: number): ButtonBuilder
	if type(style) ~= "number" or style < 1 or style > 5 then
		error("button style must be a number from 1 to 5", 2)
	end

	local component = (self :: any).component
	component.style = style
	return self
end

function ButtonBuilder:SetUrl(url: string): ButtonBuilder
	assertString("url", url, 512)

	local component = (self :: any).component
	component.url = url
	component.custom_id = nil
	component.style = LINK_BUTTON_STYLE
	return self
end

function ButtonBuilder:SetDisabled(disabled: boolean): ButtonBuilder
	if type(disabled) ~= "boolean" then
		error("disabled must be a boolean", 2)
	end

	local component = (self :: any).component
	component.disabled = disabled
	return self
end

function ButtonBuilder:Build(): { [string]: any }
	local component = (self :: any).component

	if type(component.style) ~= "number" then
		error("button style is required", 2)
	end

	if component.style == LINK_BUTTON_STYLE then
		if type(component.url) ~= "string" or component.url == "" then
			error("link buttons require a url", 2)
		end
	else
		if type(component.custom_id) ~= "string" or component.custom_id == "" then
			error("non-link buttons require a customId", 2)
		end
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return ButtonBuilder
