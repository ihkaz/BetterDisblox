local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})

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

client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type ~= 2 then
		return
	end

	if interaction.CommandName == "ping" then
		interaction:Reply("pong")
		return
	end

	if interaction.CommandName == "say" then
		interaction:Reply(interaction:GetString("text") or "")
	end
end)

client:Login()
