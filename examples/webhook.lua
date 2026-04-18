local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()

local webhook = BetterDisblox.WebhookClient.new("WEBHOOK_URL", {
	Wait = true,
	Username = "BetterDisblox",
	AvatarUrl = "https://example.com/avatar.png",
})

local message = webhook:Send({
	content = "Hello from BetterDisblox",
	embeds = {
		BetterDisblox.EmbedBuilder.new()
			:SetTitle("Webhook")
			:SetDescription("No Gateway or bot token required.")
			:SetColor("#57F287")
			:SetFooter({
				text = "Powered by BetterDisblox",
			})
			:SetTimestampNow()
			:Build(),
	},
})

if message ~= nil then
	webhook:EditMessage(message.id, "Edited webhook message", {
		ThreadId = "THREAD_ID",
	})
end
