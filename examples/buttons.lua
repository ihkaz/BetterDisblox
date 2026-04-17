local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()

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
	if interaction.Type == 2 and interaction.CommandName == "buttons" then
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

		interaction:Reply({
			content = "Choose an action",
			components = { row },
		})
		return
	end

	if interaction.Type == 3 and interaction.CustomId == "confirm" then
		interaction:ReplyEphemeral("Confirmed")
		return
	end

	if interaction.Type == 3 and interaction.CustomId == "cancel" then
		interaction:ReplyEphemeral("Cancelled")
	end
end)

client:Login()
