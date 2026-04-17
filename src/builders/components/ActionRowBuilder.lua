--!strict

export type ActionRowBuilder = {
	AddComponents: (self: ActionRowBuilder, ...any) -> ActionRowBuilder,
	SetComponents: (self: ActionRowBuilder, components: { any }) -> ActionRowBuilder,
	Build: (self: ActionRowBuilder) -> { [string]: any },
}

local ActionRowBuilder = {}
ActionRowBuilder.__index = ActionRowBuilder

local COMPONENT_TYPE_ACTION_ROW = 1
local MAX_COMPONENTS = 5

function ActionRowBuilder.new(): ActionRowBuilder
	local self = {
		components = {} :: { any },
	}

	return (setmetatable(self, ActionRowBuilder) :: any) :: ActionRowBuilder
end

local function normalizeComponent(component: any): any
	if type(component) ~= "table" then
		error("component must be a table", 3)
	end

	if type(component.Build) == "function" then
		return component:Build()
	end

	return component
end

function ActionRowBuilder:AddComponents(...: any): ActionRowBuilder
	local state = self :: any
	local components = table.pack(...)

	for index = 1, components.n do
		if #state.components >= MAX_COMPONENTS then
			error("action rows can contain at most five components", 2)
		end

		table.insert(state.components, normalizeComponent(components[index]))
	end

	return self
end

function ActionRowBuilder:SetComponents(components: { any }): ActionRowBuilder
	if type(components) ~= "table" then
		error("components must be a table", 2)
	end

	if #components > MAX_COMPONENTS then
		error("action rows can contain at most five components", 2)
	end

	local normalizedComponents: { any } = {}
	for _, component in ipairs(components) do
		table.insert(normalizedComponents, normalizeComponent(component))
	end

	local state = self :: any
	state.components = normalizedComponents
	return self
end

function ActionRowBuilder:Build(): { [string]: any }
	local state = self :: any

	if #state.components < 1 then
		error("action rows require at least one component", 2)
	end

	return {
		type = COMPONENT_TYPE_ACTION_ROW,
		components = state.components,
	}
end

return ActionRowBuilder
