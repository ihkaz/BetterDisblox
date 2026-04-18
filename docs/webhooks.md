# Webhooks

`WebhookClient` sends Discord webhook messages without Gateway or a bot token.

```lua
local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

local webhook = BetterDisblox.WebhookClient.new("WEBHOOK_URL", {
	Wait = true,
	Username = "BetterDisblox",
	AvatarUrl = "https://example.com/avatar.png",
})

local message = webhook:Send({
	content = "Hello from BetterDisblox",
})
```

## Edit A Message

`Wait = true` makes Discord return the created message.

```lua
if message ~= nil then
	webhook:EditMessage(message.id, "Edited webhook message", {
		ThreadId = "THREAD_ID",
	})
end
```

## Delete A Message

```lua
webhook:DeleteMessage("MESSAGE_ID", {
	ThreadId = "THREAD_ID",
})
```

Webhook requests use HTTP, not WebSocket.

## Components v2

Webhook messages can use Components v2 payloads.

```lua
local container = BetterDisblox.ContainerBuilder.new()
	:SetBlurple()
	:AddComponents(
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("## BetterDisblox"),
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("Webhook message using Components v2.")
	)
	:Build()

webhook:Send({
	flags = BetterDisblox.MessageFlags.IsComponentsV2,
	components = { container },
})
```
