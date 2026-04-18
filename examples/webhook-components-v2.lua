local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local webhook = BetterDisblox.WebhookClient.new("WEBHOOK_URL", {
	Wait = true,
	Username = "BetterDisblox",
	AvatarUrl = "https://example.com/avatar.png",
})

local container = BetterDisblox.ContainerBuilder.new()
	:SetBlurple()
	:AddComponents(
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("## BetterDisblox"),

		BetterDisblox.SeparatorBuilder.new()
			:SetSpacing(BetterDisblox.SeparatorSpacing.Large),

		BetterDisblox.SectionBuilder.new()
			:AddComponents(
				BetterDisblox.TextDisplayBuilder.new()
					:SetContent("Webhook message using Components v2.")
			)
			:SetAccessory(
				BetterDisblox.ThumbnailBuilder.new()
					:SetUrl("https://example.com/avatar.png")
					:SetDescription("Webhook avatar")
			),

		BetterDisblox.MediaGalleryBuilder.new()
			:AddItems({
				url = "https://example.com/banner.png",
				description = "Webhook banner",
			}),

		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("No Gateway or bot token required.")
	)
	:Build()

local message = webhook:Send({
	flags = BetterDisblox.MessageFlags.IsComponentsV2,
	components = { container },
})

if message ~= nil then
	print("Sent webhook Components v2 message: " .. message.id)
end
