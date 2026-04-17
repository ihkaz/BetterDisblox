--!strict

export type ContainerBuilder = {
	SetAccentColor: (self: ContainerBuilder, color: number) -> ContainerBuilder,
	SetSpoiler: (self: ContainerBuilder, spoiler: boolean) -> ContainerBuilder,
	AddComponents: (self: ContainerBuilder, ...any) -> ContainerBuilder,
	SetComponents: (self: ContainerBuilder, components: { any }) -> ContainerBuilder,
	Build: (self: ContainerBuilder) -> { [string]: any },
}

local ContainerBuilder = {}
ContainerBuilder.__index = ContainerBuilder

local COMPONENT_TYPE_CONTAINER = 17
local MAX_COMPONENTS = 40

local function normalizeComponent(component: any): any
	if type(component) ~= "table" then
		error("container component must be a table", 3)
	end

	if type(component.Build) == "function" then
		return component:Build()
	end

	return component
end

function ContainerBuilder.new(): ContainerBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_CONTAINER,
			components = {} :: { any },
		} :: { [string]: any },
	}

	return (setmetatable(self, ContainerBuilder) :: any) :: ContainerBuilder
end

function ContainerBuilder:SetAccentColor(color: number): ContainerBuilder
	if type(color) ~= "number" or color < 0 or color > 0xFFFFFF then
		error("color must be a number from 0x000000 to 0xFFFFFF", 2)
	end

	local component = (self :: any).component
	component.accent_color = color
	return self
end

function ContainerBuilder:SetSpoiler(spoiler: boolean): ContainerBuilder
	if type(spoiler) ~= "boolean" then
		error("spoiler must be a boolean", 2)
	end

	local component = (self :: any).component
	component.spoiler = spoiler
	return self
end

function ContainerBuilder:AddComponents(...: any): ContainerBuilder
	local component = (self :: any).component
	local components = table.pack(...)

	for index = 1, components.n do
		if #component.components >= MAX_COMPONENTS then
			error("containers can contain at most 40 components", 2)
		end

		table.insert(component.components, normalizeComponent(components[index]))
	end

	return self
end

function ContainerBuilder:SetComponents(components: { any }): ContainerBuilder
	if type(components) ~= "table" then
		error("components must be a table", 2)
	end

	if #components > MAX_COMPONENTS then
		error("containers can contain at most 40 components", 2)
	end

	local normalizedComponents: { any } = {}
	for _, component in ipairs(components) do
		table.insert(normalizedComponents, normalizeComponent(component))
	end

	local component = (self :: any).component
	component.components = normalizedComponents
	return self
end

function ContainerBuilder:Build(): { [string]: any }
	local component = (self :: any).component

	if #component.components < 1 then
		error("containers require at least one component", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return ContainerBuilder
