# BetterDisblox

BetterDisblox is a Discord Gateway and REST client for Roblox executor environments.

It is built for executors that support UNC-style `request`, `WebSocket.connect`, and optional filesystem APIs. The API is inspired by `discord.js`, but implemented in Luau and bundled into one file with Darklua.

## Load BetterDisblox

```lua
local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()
```

## Basic Bot

```lua
local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds
		+ BetterDisblox.Intents.GuildMessages
		+ BetterDisblox.Intents.MessageContent,
	SessionPersistence = true,
})

client:On("READY", function(data)
	print("Ready as " .. data.user.username)
end)

client:On("MESSAGE_CREATE", function(message)
	if message.Content == "!ping" then
		message:Reply("pong")
	end
end)

client:Login()
```

## Features

- Discord Gateway login, heartbeat, reconnect, and resume.
- Optional session persistence with UNC filesystem APIs.
- REST helpers for messages, users, channels, guilds, and slash commands.
- Interaction helpers for replies, defers, edits, followups, modals, and component updates.
- Builders for slash commands, embeds, buttons, selects, modals, and Components v2.
- Webhook client without Gateway or WebSocket.
- `Collection` utility for command registries and future caches.

## Important

Never publish a Discord bot token inside executor scripts. Executor scripts are client-side and tokens can be extracted.
