--!strict

export type SectionBuilder = {
	AddComponents: (self: SectionBuilder, ...any) -> SectionBuilder,
	SetComponents: (self: SectionBuilder, components: { any }) -> SectionBuilder,
	SetAccessory: (self: SectionBuilder, accessory: any) -> SectionBuilder,
	Build: (self: SectionBuilder) -> { [string]: any },
}

local SectionBuilder = {}
SectionBuilder.__index = SectionBuilder

local COMPONENT_TYPE_SECTION = 9
local MAX_TEXT_COMPONENTS = 3

local function normalizeComponent(component: any): any
	if type(component) ~= "table" then
		error("section component must be a table", 3)
	end

	if type(component.Build) == "function" then
		return component:Build()
	end

	return component
end

function SectionBuilder.new(): SectionBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_SECTION,
			components = {} :: { any },
		} :: { [string]: any },
	}

	return (setmetatable(self, SectionBuilder) :: any) :: SectionBuilder
end

function SectionBuilder:AddComponents(...: any): SectionBuilder
	local component = (self :: any).component
	local components = table.pack(...)

	for index = 1, components.n do
		if #component.components >= MAX_TEXT_COMPONENTS then
			error("sections can contain at most three text components", 2)
		end

		table.insert(component.components, normalizeComponent(components[index]))
	end

	return self
end

function SectionBuilder:SetComponents(components: { any }): SectionBuilder
	if type(components) ~= "table" then
		error("components must be a table", 2)
	end

	if #components > MAX_TEXT_COMPONENTS then
		error("sections can contain at most three text components", 2)
	end

	local normalizedComponents: { any } = {}
	for _, component in ipairs(components) do
		table.insert(normalizedComponents, normalizeComponent(component))
	end

	local component = (self :: any).component
	component.components = normalizedComponents
	return self
end

function SectionBuilder:SetAccessory(accessory: any): SectionBuilder
	local component = (self :: any).component
	component.accessory = normalizeComponent(accessory)
	return self
end

function SectionBuilder:Build(): { [string]: any }
	local component = (self :: any).component

	if #component.components < 1 then
		error("sections require at least one text component", 2)
	end

	if type(component.accessory) ~= "table" then
		error("sections require an accessory component", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return SectionBuilder
