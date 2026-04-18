local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

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
		message:reply("pong")
	end
end)

client:Login()
