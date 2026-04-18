--!strict

local Payload = require("./Payload")

export type Message = {
	Id: string,
	ChannelId: string,
	GuildId: string?,
	Content: string,
	Author: any,
	Raw: any,
	Reply: (self: Message, payload: any) -> any,
	reply: (self: Message, payload: any) -> any,
	Edit: (self: Message, payload: any) -> any,
	edit: (self: Message, payload: any) -> any,
	Delete: (self: Message) -> any,
	delete: (self: Message) -> any,
}

local Message = {}
Message.__index = Message

function Message.new(rawMessage: any, restClient: any): Message
	if type(rawMessage) ~= "table" then
		error("rawMessage must be a table", 2)
	end

	if type(restClient) ~= "table" then
		error("restClient must be a table", 2)
	end

	local self = {
		Id = rawMessage.id,
		ChannelId = rawMessage.channel_id,
		GuildId = rawMessage.guild_id,
		Content = rawMessage.content or "",
		Author = rawMessage.author,
		Raw = rawMessage,
		restClient = restClient,
	}

	return (setmetatable(self, Message) :: any) :: Message
end

function Message:Reply(payload: any): any
	local state = self :: any
	return state.restClient:CreateMessage(state.ChannelId, Payload.Message(payload))
end

function Message:Edit(payload: any): any
	local state = self :: any
	return state.restClient:EditMessage(state.ChannelId, state.Id, Payload.Message(payload))
end

function Message:Delete(): any
	local state = self :: any
	return state.restClient:DeleteMessage(state.ChannelId, state.Id)
end

Message.reply = Message.Reply
Message.edit = Message.Edit
Message.delete = Message.Delete

return Message
