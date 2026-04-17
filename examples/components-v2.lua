local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})

local commands = {
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("v2")
		:SetDescription("Sends a Components v2 message")
		:Build(),
}

client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type ~= 2 or interaction.CommandName ~= "v2" then
		return
	end

	local container = BetterDisblox.ContainerBuilder.new()
		:SetGreen()
		:AddComponents(
			BetterDisblox.TextDisplayBuilder.new()
				:SetContent("## BetterDisblox"),

			BetterDisblox.SeparatorBuilder.new()
				:SetSpacing(BetterDisblox.SeparatorSpacing.Large),

			BetterDisblox.SectionBuilder.new()
				:AddComponents(
					BetterDisblox.TextDisplayBuilder.new()
						:SetContent("Components v2 from a Roblox executor.")
				)
				:SetAccessory(
					BetterDisblox.ButtonBuilder.new()
						:SetCustomId("v2_ok")
						:SetLabel("OK")
						:SetSuccess()
				),

			BetterDisblox.TextDisplayBuilder.new()
				:SetContent("Built with BetterDisblox.")
		)
		:Build()

	interaction:Reply({
		flags = BetterDisblox.MessageFlags.IsComponentsV2,
		components = { container },
	})
end)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type == 3 and interaction.CustomId == "v2_ok" then
		interaction:ReplyEphemeral("OK")
	end
end)

client:Login()
