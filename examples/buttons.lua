local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})

local commands = {
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("buttons")
		:SetDescription("Sends button components")
		:Build(),
}

client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction:isChatInputCommand() and interaction.CommandName == "buttons" then
		local row = BetterDisblox.ActionRowBuilder.new()
			:AddComponents(
				BetterDisblox.ButtonBuilder.new()
					:SetCustomId("confirm")
					:SetLabel("Confirm")
					:SetSuccess(),
				BetterDisblox.ButtonBuilder.new()
					:SetCustomId("cancel")
					:SetLabel("Cancel")
					:SetDanger()
			)
			:Build()

		interaction:reply({
			content = "Choose an action",
			components = { row },
		})
		return
	end

	if interaction:isButton() and interaction.CustomId == "confirm" then
		interaction:replyEphemeral("Confirmed")
		return
	end

	if interaction:isButton() and interaction.CustomId == "cancel" then
		interaction:replyEphemeral("Cancelled")
	end
end)

client:Login()
