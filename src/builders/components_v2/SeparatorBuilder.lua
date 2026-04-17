--!strict

export type SeparatorBuilder = {
	SetDivider: (self: SeparatorBuilder, divider: boolean) -> SeparatorBuilder,
	SetSpacing: (self: SeparatorBuilder, spacing: number) -> SeparatorBuilder,
	Build: (self: SeparatorBuilder) -> { [string]: any },
}

local SeparatorBuilder = {}
SeparatorBuilder.__index = SeparatorBuilder

local COMPONENT_TYPE_SEPARATOR = 14

function SeparatorBuilder.new(): SeparatorBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_SEPARATOR,
		} :: { [string]: any },
	}

	return (setmetatable(self, SeparatorBuilder) :: any) :: SeparatorBuilder
end

function SeparatorBuilder:SetDivider(divider: boolean): SeparatorBuilder
	if type(divider) ~= "boolean" then
		error("divider must be a boolean", 2)
	end

	local component = (self :: any).component
	component.divider = divider
	return self
end

function SeparatorBuilder:SetSpacing(spacing: number): SeparatorBuilder
	if type(spacing) ~= "number" or (spacing ~= 1 and spacing ~= 2) then
		error("spacing must be SeparatorSpacing.Small or SeparatorSpacing.Large", 2)
	end

	local component = (self :: any).component
	component.spacing = spacing
	return self
end

function SeparatorBuilder:Build(): { [string]: any }
	local component = (self :: any).component
	local output: { [string]: any } = {}

	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return SeparatorBuilder
