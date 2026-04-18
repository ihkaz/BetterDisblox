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
