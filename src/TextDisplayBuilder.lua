--!strict

export type TextDisplayBuilder = {
	SetContent: (self: TextDisplayBuilder, content: string) -> TextDisplayBuilder,
	Build: (self: TextDisplayBuilder) -> { [string]: any },
}

local TextDisplayBuilder = {}
TextDisplayBuilder.__index = TextDisplayBuilder

local COMPONENT_TYPE_TEXT_DISPLAY = 10

function TextDisplayBuilder.new(): TextDisplayBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_TEXT_DISPLAY,
		} :: { [string]: any },
	}

	return (setmetatable(self, TextDisplayBuilder) :: any) :: TextDisplayBuilder
end

function TextDisplayBuilder:SetContent(content: string): TextDisplayBuilder
	if type(content) ~= "string" or content == "" then
		error("content must be a non-empty string", 2)
	end

	if #content > 4000 then
		error("content must be 4000 characters or fewer", 2)
	end

	local component = (self :: any).component
	component.content = content
	return self
end

function TextDisplayBuilder:Build(): { [string]: any }
	local component = (self :: any).component

	if type(component.content) ~= "string" or component.content == "" then
		error("text displays require content", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return TextDisplayBuilder
