--!strict

export type ThumbnailBuilder = {
	SetUrl: (self: ThumbnailBuilder, url: string) -> ThumbnailBuilder,
	SetDescription: (self: ThumbnailBuilder, description: string) -> ThumbnailBuilder,
	SetSpoiler: (self: ThumbnailBuilder, spoiler: boolean) -> ThumbnailBuilder,
	Build: (self: ThumbnailBuilder) -> { [string]: any },
}

local ThumbnailBuilder = {}
ThumbnailBuilder.__index = ThumbnailBuilder

local COMPONENT_TYPE_THUMBNAIL = 11

local function assertString(name: string, value: string, maxLength: number): ()
	if type(value) ~= "string" or value == "" then
		error(name .. " must be a non-empty string", 3)
	end

	if #value > maxLength then
		error(name .. " must be " .. tostring(maxLength) .. " characters or fewer", 3)
	end
end

function ThumbnailBuilder.new(): ThumbnailBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_THUMBNAIL,
		} :: { [string]: any },
	}

	return (setmetatable(self, ThumbnailBuilder) :: any) :: ThumbnailBuilder
end

function ThumbnailBuilder:SetUrl(url: string): ThumbnailBuilder
	assertString("url", url, 512)
	local component = (self :: any).component
	component.media = {
		url = url,
	}
	return self
end

function ThumbnailBuilder:SetDescription(description: string): ThumbnailBuilder
	assertString("description", description, 1024)
	local component = (self :: any).component
	component.description = description
	return self
end

function ThumbnailBuilder:SetSpoiler(spoiler: boolean): ThumbnailBuilder
	if type(spoiler) ~= "boolean" then
		error("spoiler must be a boolean", 2)
	end

	local component = (self :: any).component
	component.spoiler = spoiler
	return self
end

function ThumbnailBuilder:Build(): { [string]: any }
	local component = (self :: any).component
	if type(component.media) ~= "table" or type(component.media.url) ~= "string" then
		error("thumbnails require a url", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return ThumbnailBuilder
