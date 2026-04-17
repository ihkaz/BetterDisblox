--!strict

local Color = require("../util/Color")

export type EmbedBuilder = {
	SetTitle: (self: EmbedBuilder, title: string) -> EmbedBuilder,
	SetDescription: (self: EmbedBuilder, description: string) -> EmbedBuilder,
	SetColor: (self: EmbedBuilder, color: Color.ColorResolvable) -> EmbedBuilder,
	SetUrl: (self: EmbedBuilder, url: string) -> EmbedBuilder,
	SetTimestamp: (self: EmbedBuilder, timestamp: string) -> EmbedBuilder,
	SetTimestampNow: (self: EmbedBuilder) -> EmbedBuilder,
	SetAuthor: (self: EmbedBuilder, author: { [string]: any }) -> EmbedBuilder,
	SetFooter: (self: EmbedBuilder, footer: { [string]: any }) -> EmbedBuilder,
	SetThumbnail: (self: EmbedBuilder, url: string) -> EmbedBuilder,
	SetImage: (self: EmbedBuilder, url: string) -> EmbedBuilder,
	AddField: (self: EmbedBuilder, name: string, value: string, inline: boolean) -> EmbedBuilder,
	AddFields: (self: EmbedBuilder, ...any) -> EmbedBuilder,
	SetFields: (self: EmbedBuilder, fields: { any }) -> EmbedBuilder,
	ClearFields: (self: EmbedBuilder) -> EmbedBuilder,
	Build: (self: EmbedBuilder) -> { [string]: any },
}

local EmbedBuilder = {}
EmbedBuilder.__index = EmbedBuilder

function EmbedBuilder.new(): EmbedBuilder
	local self = {
		embed = {} :: { [string]: any },
	}

	return (setmetatable(self, EmbedBuilder) :: any) :: EmbedBuilder
end

function EmbedBuilder:SetTitle(title: string): EmbedBuilder
	if type(title) ~= "string" or title == "" then
		error("title must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.title = title
	return self
end

function EmbedBuilder:SetDescription(description: string): EmbedBuilder
	if type(description) ~= "string" or description == "" then
		error("description must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.description = description
	return self
end

function EmbedBuilder:SetColor(color: Color.ColorResolvable): EmbedBuilder
	local state = self :: any
	state.embed.color = Color.Resolve(color)
	return self
end

function EmbedBuilder:SetUrl(url: string): EmbedBuilder
	if type(url) ~= "string" or url == "" then
		error("url must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.url = url
	return self
end

function EmbedBuilder:SetTimestamp(timestamp: string): EmbedBuilder
	if type(timestamp) ~= "string" or timestamp == "" then
		error("timestamp must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.timestamp = timestamp
	return self
end

function EmbedBuilder:SetTimestampNow(): EmbedBuilder
	local state = self :: any
	state.embed.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
	return self
end

local function copyObject(name: string, value: { [string]: any }): { [string]: any }
	if type(value) ~= "table" then
		error(name .. " must be a table", 3)
	end

	local output: { [string]: any } = {}
	for key, fieldValue in pairs(value) do
		output[key] = fieldValue
	end

	return output
end

function EmbedBuilder:SetAuthor(author: { [string]: any }): EmbedBuilder
	local copiedAuthor = copyObject("author", author)
	if type(copiedAuthor.name) ~= "string" or copiedAuthor.name == "" then
		error("author.name must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.author = copiedAuthor
	return self
end

function EmbedBuilder:SetFooter(footer: { [string]: any }): EmbedBuilder
	local copiedFooter = copyObject("footer", footer)
	if type(copiedFooter.text) ~= "string" or copiedFooter.text == "" then
		error("footer.text must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.footer = copiedFooter
	return self
end

function EmbedBuilder:SetThumbnail(url: string): EmbedBuilder
	if type(url) ~= "string" or url == "" then
		error("thumbnail url must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.thumbnail = {
		url = url,
	}

	return self
end

function EmbedBuilder:SetImage(url: string): EmbedBuilder
	if type(url) ~= "string" or url == "" then
		error("image url must be a non-empty string", 2)
	end

	local state = self :: any
	state.embed.image = {
		url = url,
	}

	return self
end

local function normalizeField(field: any): { [string]: any }
	if type(field) ~= "table" then
		error("field must be a table", 3)
	end

	if type(field.name) ~= "string" or field.name == "" then
		error("field.name must be a non-empty string", 3)
	end

	if type(field.value) ~= "string" or field.value == "" then
		error("field.value must be a non-empty string", 3)
	end

	local inline = field.inline
	if inline == nil then
		inline = false
	end

	if type(inline) ~= "boolean" then
		error("field.inline must be a boolean when provided", 3)
	end

	return {
		name = field.name,
		value = field.value,
		inline = inline,
	}
end

function EmbedBuilder:AddField(name: string, value: string, inline: boolean): EmbedBuilder
	if type(name) ~= "string" or name == "" then
		error("name must be a non-empty string", 2)
	end

	if type(value) ~= "string" or value == "" then
		error("value must be a non-empty string", 2)
	end

	if type(inline) ~= "boolean" then
		error("inline must be a boolean", 2)
	end

	local embed = (self :: any).embed
	if embed.fields == nil then
		embed.fields = {}
	end

	table.insert(embed.fields, {
		name = name,
		value = value,
		inline = inline,
	})

	return self
end

function EmbedBuilder:AddFields(...: any): EmbedBuilder
	local state = self :: any
	if state.embed.fields == nil then
		state.embed.fields = {}
	end

	local fields = table.pack(...)
	for index = 1, fields.n do
		table.insert(state.embed.fields, normalizeField(fields[index]))
	end

	return self
end

function EmbedBuilder:SetFields(fields: { any }): EmbedBuilder
	if type(fields) ~= "table" then
		error("fields must be a table", 2)
	end

	local normalizedFields: { any } = {}
	for _, field in ipairs(fields) do
		table.insert(normalizedFields, normalizeField(field))
	end

	local state = self :: any
	state.embed.fields = normalizedFields
	return self
end

function EmbedBuilder:ClearFields(): EmbedBuilder
	local state = self :: any
	state.embed.fields = {}
	return self
end

function EmbedBuilder:Build(): { [string]: any }
	local output: { [string]: any } = {}

	for key, value in pairs((self :: any).embed) do
		output[key] = value
	end

	return output
end

return EmbedBuilder
