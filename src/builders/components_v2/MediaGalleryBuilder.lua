--!strict

export type MediaGalleryBuilder = {
	AddItems: (self: MediaGalleryBuilder, ...any) -> MediaGalleryBuilder,
	SetItems: (self: MediaGalleryBuilder, items: { any }) -> MediaGalleryBuilder,
	Build: (self: MediaGalleryBuilder) -> { [string]: any },
}

local MediaGalleryBuilder = {}
MediaGalleryBuilder.__index = MediaGalleryBuilder

local COMPONENT_TYPE_MEDIA_GALLERY = 12
local MAX_ITEMS = 10

local function normalizeItem(item: any): any
	if type(item) ~= "table" then
		error("media gallery item must be a table", 3)
	end

	if type(item.Build) == "function" then
		return item:Build()
	end

	if type(item.url) == "string" then
		local normalized = {
			media = {
				url = item.url,
			},
		}

		if item.description ~= nil then
			normalized.description = item.description
		end

		if item.spoiler ~= nil then
			normalized.spoiler = item.spoiler
		end

		return normalized
	end

	if type(item.media) ~= "table" or type(item.media.url) ~= "string" then
		error("media gallery items require media.url or url", 3)
	end

	return item
end

function MediaGalleryBuilder.new(): MediaGalleryBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_MEDIA_GALLERY,
			items = {} :: { any },
		} :: { [string]: any },
	}

	return (setmetatable(self, MediaGalleryBuilder) :: any) :: MediaGalleryBuilder
end

function MediaGalleryBuilder:AddItems(...: any): MediaGalleryBuilder
	local component = (self :: any).component
	local items = table.pack(...)

	for index = 1, items.n do
		if #component.items >= MAX_ITEMS then
			error("media galleries can contain at most 10 items", 2)
		end

		table.insert(component.items, normalizeItem(items[index]))
	end

	return self
end

function MediaGalleryBuilder:SetItems(items: { any }): MediaGalleryBuilder
	if type(items) ~= "table" then
		error("items must be a table", 2)
	end

	if #items > MAX_ITEMS then
		error("media galleries can contain at most 10 items", 2)
	end

	local normalizedItems: { any } = {}
	for _, item in ipairs(items) do
		table.insert(normalizedItems, normalizeItem(item))
	end

	local component = (self :: any).component
	component.items = normalizedItems
	return self
end

function MediaGalleryBuilder:Build(): { [string]: any }
	local component = (self :: any).component
	if #component.items < 1 then
		error("media galleries require at least one item", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return MediaGalleryBuilder
