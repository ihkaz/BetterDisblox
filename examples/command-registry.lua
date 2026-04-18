local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})

client:EnableConsoleDebug()

local registry = BetterDisblox.CommandRegistry.new()

local commands = {
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("ping")
		:SetDescription("Replies with pong")
		:Build(),
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("say")
		:SetDescription("Replies with your text")
		:AddStringOption("text", "Text to send", true)
		:Build(),
}

registry:register("ping", function(interaction)
	interaction:reply("pong")
end)

registry:register("say", function(interaction)
	interaction:reply(interaction:GetString("text") or "")
end)

client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)

client:On("INTERACTION_CREATE", function(interaction)
	registry:handle(interaction)
end)

client:Login()
