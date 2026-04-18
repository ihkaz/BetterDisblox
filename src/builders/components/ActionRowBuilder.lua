--!strict

export type ActionRowBuilder = {
	AddComponents: (self: ActionRowBuilder, ...any) -> ActionRowBuilder,
	SetComponents: (self: ActionRowBuilder, components: { any }) -> ActionRowBuilder,
	Build: (self: ActionRowBuilder) -> { [string]: any },
}

local ActionRowBuilder = {}
ActionRowBuilder.__index = ActionRowBuilder

local COMPONENT_TYPE_ACTION_ROW = 1
local COMPONENT_TYPE_BUTTON = 2
local COMPONENT_TYPE_STRING_SELECT = 3
local COMPONENT_TYPE_TEXT_INPUT = 4
local COMPONENT_TYPE_USER_SELECT = 5
local COMPONENT_TYPE_ROLE_SELECT = 6
local COMPONENT_TYPE_MENTIONABLE_SELECT = 7
local COMPONENT_TYPE_CHANNEL_SELECT = 8
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

local function isSingleComponentType(componentType: any): boolean
	return componentType == COMPONENT_TYPE_STRING_SELECT
		or componentType == COMPONENT_TYPE_TEXT_INPUT
		or componentType == COMPONENT_TYPE_USER_SELECT
		or componentType == COMPONENT_TYPE_ROLE_SELECT
		or componentType == COMPONENT_TYPE_MENTIONABLE_SELECT
		or componentType == COMPONENT_TYPE_CHANNEL_SELECT
end

local function validateComponents(components: { any }): ()
	if #components < 1 then
		error("action rows require at least one component", 3)
	end

	if #components > MAX_COMPONENTS then
		error("action rows can contain at most five components", 3)
	end

	local firstComponent = components[1]
	if type(firstComponent) ~= "table" or type(firstComponent.type) ~= "number" then
		error("action row components require a numeric type", 3)
	end

	if firstComponent.type == COMPONENT_TYPE_BUTTON then
		for _, component in ipairs(components) do
			if type(component) ~= "table" or component.type ~= COMPONENT_TYPE_BUTTON then
				error("action rows cannot mix buttons with other component types", 3)
			end
		end

		return
	end

	if isSingleComponentType(firstComponent.type) then
		if #components ~= 1 then
			error("action rows can contain only one select menu or text input", 3)
		end

		return
	end

	error("unsupported action row component type: " .. tostring(firstComponent.type), 3)
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

	validateComponents(state.components)

	return {
		type = COMPONENT_TYPE_ACTION_ROW,
		components = state.components,
	}
end

return ActionRowBuilder
