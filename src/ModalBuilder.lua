--!strict

export type ModalBuilder = {
	SetCustomId: (self: ModalBuilder, customId: string) -> ModalBuilder,
	SetTitle: (self: ModalBuilder, title: string) -> ModalBuilder,
	AddComponents: (self: ModalBuilder, ...any) -> ModalBuilder,
	SetComponents: (self: ModalBuilder, components: { any }) -> ModalBuilder,
	Build: (self: ModalBuilder) -> { [string]: any },
}

local ModalBuilder = {}
ModalBuilder.__index = ModalBuilder

local MAX_ACTION_ROWS = 5

local function assertString(name: string, value: string, maxLength: number): ()
	if type(value) ~= "string" or value == "" then
		error(name .. " must be a non-empty string", 3)
	end

	if #value > maxLength then
		error(name .. " must be " .. tostring(maxLength) .. " characters or fewer", 3)
	end
end

local function normalizeComponent(component: any): any
	if type(component) ~= "table" then
		error("modal component must be a table", 3)
	end

	if type(component.Build) == "function" then
		return component:Build()
	end

	return component
end

function ModalBuilder.new(): ModalBuilder
	local self = {
		modal = {
			components = {} :: { any },
		} :: { [string]: any },
	}

	return (setmetatable(self, ModalBuilder) :: any) :: ModalBuilder
end

function ModalBuilder:SetCustomId(customId: string): ModalBuilder
	assertString("customId", customId, 100)
	local modal = (self :: any).modal
	modal.custom_id = customId
	return self
end

function ModalBuilder:SetTitle(title: string): ModalBuilder
	assertString("title", title, 45)
	local modal = (self :: any).modal
	modal.title = title
	return self
end

function ModalBuilder:AddComponents(...: any): ModalBuilder
	local modal = (self :: any).modal
	local components = table.pack(...)

	for index = 1, components.n do
		if #modal.components >= MAX_ACTION_ROWS then
			error("modals can contain at most five action rows", 2)
		end

		table.insert(modal.components, normalizeComponent(components[index]))
	end

	return self
end

function ModalBuilder:SetComponents(components: { any }): ModalBuilder
	if type(components) ~= "table" then
		error("components must be a table", 2)
	end

	if #components > MAX_ACTION_ROWS then
		error("modals can contain at most five action rows", 2)
	end

	local normalizedComponents: { any } = {}
	for _, component in ipairs(components) do
		table.insert(normalizedComponents, normalizeComponent(component))
	end

	local modal = (self :: any).modal
	modal.components = normalizedComponents
	return self
end

function ModalBuilder:Build(): { [string]: any }
	local modal = (self :: any).modal

	if type(modal.custom_id) ~= "string" or modal.custom_id == "" then
		error("modals require a customId", 2)
	end

	if type(modal.title) ~= "string" or modal.title == "" then
		error("modals require a title", 2)
	end

	if #modal.components < 1 then
		error("modals require at least one action row", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(modal) do
		output[key] = value
	end

	return output
end

return ModalBuilder
