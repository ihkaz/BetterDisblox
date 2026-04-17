local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})

local commands = {
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("feedback")
		:SetDescription("Opens a feedback modal")
		:Build(),
}

client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type == 2 and interaction.CommandName == "feedback" then
		local modal = BetterDisblox.ModalBuilder.new()
			:SetCustomId("feedback_modal")
			:SetTitle("Feedback")
			:AddComponents(
				BetterDisblox.ActionRowBuilder.new()
					:AddComponents(
						BetterDisblox.TextInputBuilder.new()
							:SetCustomId("feedback_text")
							:SetLabel("Your feedback")
							:SetStyle(BetterDisblox.TextInputStyle.Paragraph)
							:SetRequired(true)
							:SetPlaceholder("Write your feedback here")
					)
			)

		interaction:ShowModal(modal)
		return
	end

	if interaction.Type == 5 and interaction.CustomId == "feedback_modal" then
		local feedback = interaction:GetTextInputValue("feedback_text") or ""
		interaction:ReplyEphemeral("Thanks: " .. feedback)
	end
end)

client:Login()
