local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})

local registry = BetterDisblox.CommandRegistry.new()
local applicationId = "APPLICATION_ID"
local guildId = "GUILD_ID"

local commands = {
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("panel")
		:SetDescription("Open the BetterDisblox control panel"),
}

local function buildPanel(statusText)
	local container = BetterDisblox.ContainerBuilder.new()
		:SetColor("#5865F2")
		:AddComponents(
			BetterDisblox.TextDisplayBuilder.new()
				:SetContent("## BetterDisblox Control Panel"),

			BetterDisblox.SeparatorBuilder.new()
				:SetSpacing(BetterDisblox.SeparatorSpacing.Large),

			BetterDisblox.SectionBuilder.new()
				:AddComponents(
					BetterDisblox.TextDisplayBuilder.new()
						:SetContent("**Status**\n" .. statusText),
					BetterDisblox.TextDisplayBuilder.new()
						:SetContent("Components v2 messages must use Components v2 only.")
			)
			:SetAccessory(
				BetterDisblox.ThumbnailBuilder.new()
					:SetUrl("https://cdn.discordapp.com/embed/avatars/0.png")
					:SetDescription("BetterDisblox")
			),

			BetterDisblox.MediaGalleryBuilder.new()
				:AddItems({
					url = "https://cdn.discordapp.com/embed/avatars/1.png",
					description = "Dashboard media",
				}),

			BetterDisblox.SeparatorBuilder.new()
				:SetSpacing(BetterDisblox.SeparatorSpacing.Small),

			BetterDisblox.TextDisplayBuilder.new()
				:SetContent("Use `/panel` again to refresh this dashboard.")
		)
		:Build()

	return {
		flags = BetterDisblox.MessageFlags.IsComponentsV2,
		components = { container },
	}
end

local function buildFeedbackModal()
	return BetterDisblox.ModalBuilder.new()
		:SetCustomId("panel_feedback_modal")
		:SetTitle("Panel feedback")
		:AddComponents(
			BetterDisblox.ActionRowBuilder.new()
				:AddComponents(
					BetterDisblox.TextInputBuilder.new()
						:SetCustomId("feedback_text")
						:SetLabel("What should be improved?")
						:SetStyle(BetterDisblox.TextInputStyle.Paragraph)
						:SetRequired(true)
						:SetPlaceholder("Write feedback here")
				)
		)
end

local function buildClassicControls()
	return {
		content = "Panel controls",
		components = {
			BetterDisblox.ActionRowBuilder.new()
				:AddComponents(
					BetterDisblox.ButtonBuilder.new()
						:SetCustomId("panel_feedback")
						:SetLabel("Feedback")
						:SetPrimary(),
					BetterDisblox.ButtonBuilder.new()
						:SetCustomId("panel_close")
						:SetLabel("Close")
						:SetDanger()
				)
				:Build(),
		},
	}
end

registry:register("panel", function(interaction)
	interaction:reply(buildPanel("Online and ready."))
	interaction:followUp(buildClassicControls())
end)

client.Rest:BulkOverwriteGuildApplicationCommands(applicationId, guildId, commands)

client:On("INTERACTION_CREATE", function(interaction)
	if registry:handle(interaction) then
		return
	end

	if interaction:isButton() and interaction.CustomId == "panel_feedback" then
		interaction:showModal(buildFeedbackModal())
		return
	end

	if interaction:isButton() and interaction.CustomId == "panel_close" then
		interaction:update({
			content = "Panel controls closed.",
			components = {},
		})
		return
	end

	if interaction:isModalSubmit() and interaction.CustomId == "panel_feedback_modal" then
		local feedback = interaction:GetTextInputValue("feedback_text") or ""
		interaction:replyEphemeral("Feedback received: " .. feedback)
	end
end)

client:Login()
