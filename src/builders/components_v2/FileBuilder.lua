--!strict

export type FileBuilder = {
	SetUrl: (self: FileBuilder, url: string) -> FileBuilder,
	SetSpoiler: (self: FileBuilder, spoiler: boolean) -> FileBuilder,
	Build: (self: FileBuilder) -> { [string]: any },
}

local FileBuilder = {}
FileBuilder.__index = FileBuilder

local COMPONENT_TYPE_FILE = 13

local function assertUrl(url: string): ()
	if type(url) ~= "string" or url == "" then
		error("url must be a non-empty string", 3)
	end

	if #url > 512 then
		error("url must be 512 characters or fewer", 3)
	end
end

function FileBuilder.new(): FileBuilder
	local self = {
		component = {
			type = COMPONENT_TYPE_FILE,
		} :: { [string]: any },
	}

	return (setmetatable(self, FileBuilder) :: any) :: FileBuilder
end

function FileBuilder:SetUrl(url: string): FileBuilder
	assertUrl(url)
	local component = (self :: any).component
	component.file = {
		url = url,
	}
	return self
end

function FileBuilder:SetSpoiler(spoiler: boolean): FileBuilder
	if type(spoiler) ~= "boolean" then
		error("spoiler must be a boolean", 2)
	end

	local component = (self :: any).component
	component.spoiler = spoiler
	return self
end

function FileBuilder:Build(): { [string]: any }
	local component = (self :: any).component
	if type(component.file) ~= "table" or type(component.file.url) ~= "string" then
		error("files require a url", 2)
	end

	local output: { [string]: any } = {}
	for key, value in pairs(component) do
		output[key] = value
	end

	return output
end

return FileBuilder
