local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
})

local me = client.Rest:GetCurrentUser()
print("Current user:", me.username)

local channel = client.Rest:GetChannel("CHANNEL_ID")
print("Channel:", channel.name)

local messages = client.Rest:GetChannelMessages("CHANNEL_ID", {
	limit = 10,
})

for _, message in ipairs(messages) do
	print(message.author.username, message.content)
end

client.Rest:TriggerTyping("CHANNEL_ID")

local guild = client.Rest:GetGuild("GUILD_ID")
print("Guild:", guild.name)

local channels = client.Rest:GetGuildChannels("GUILD_ID")
print("Guild channel count:", #channels)
