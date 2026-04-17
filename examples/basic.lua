local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds
		+ BetterDisblox.Intents.GuildMessages
		+ BetterDisblox.Intents.MessageContent,
	SessionPersistence = true,
})

client:On("READY", function(data)
	print("Ready as " .. data.user.username)
end)

client:On("MESSAGE_CREATE", function(message)
	if message.Content == "!ping" then
		message:Reply("pong")
	end
end)

client:Login()
