--!strict

export type EmbedBuilder = {
	SetTitle: (self: EmbedBuilder, title: string) -> EmbedBuilder,
	SetDescription: (self: EmbedBuilder, description: string) -> EmbedBuilder,
	SetColor: (self: EmbedBuilder, color: number) -> EmbedBuilder,
	SetUrl: (self: EmbedBuilder, url: string) -> EmbedBuilder,
	SetTimestamp: (self: EmbedBuilder, timestamp: string) -> EmbedBuilder,
	AddField: (self: EmbedBuilder, name: string, value: string, inline: boolean) -> EmbedBuilder,
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

function EmbedBuilder:SetColor(color: number): EmbedBuilder
	if type(color) ~= "number" then
		error("color must be a number", 2)
	end

	local state = self :: any
	state.embed.color = color
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

function EmbedBuilder:Build(): { [string]: any }
	local output: { [string]: any } = {}

	for key, value in pairs((self :: any).embed) do
		output[key] = value
	end

	return output
end

return EmbedBuilder
