local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})

local commands = {
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("colors")
		:SetDescription("Sends a color select menu")
		:Build(),
}

client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction:isChatInputCommand() and interaction.CommandName == "colors" then
		local menu = BetterDisblox.StringSelectMenuBuilder.new()
			:SetCustomId("choose_color")
			:SetPlaceholder("Choose a color")
			:SetMinValues(1)
			:SetMaxValues(1)
			:AddOptions(
				BetterDisblox.SelectMenuOptionBuilder.new()
					:SetLabel("Red")
					:SetValue("red")
					:SetDescription("Pick red"),
				BetterDisblox.SelectMenuOptionBuilder.new()
					:SetLabel("Green")
					:SetValue("green")
					:SetDescription("Pick green"),
				BetterDisblox.SelectMenuOptionBuilder.new()
					:SetLabel("Blue")
					:SetValue("blue")
					:SetDescription("Pick blue")
			)
			:Build()

		local row = BetterDisblox.ActionRowBuilder.new()
			:AddComponents(menu)
			:Build()

		interaction:reply({
			content = "Pick one",
			components = { row },
		})
		return
	end

	if interaction:isStringSelectMenu() and interaction.CustomId == "choose_color" then
		interaction:replyEphemeral("You picked " .. tostring(interaction.Values[1]))
	end
end)

client:Login()
