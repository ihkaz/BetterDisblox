# Getting Started

Create a client with a bot token and the Gateway intents your bot needs.

```lua
local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

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

## Events

Use `client:On(eventName, callback)` for repeated events:

```lua
client:On("MESSAGE_CREATE", function(message)
	print(message.Content)
end)
```

Use `client:Once(eventName, callback)` for one-time events:

```lua
client:Once("READY", function(data)
	print("Logged in")
end)
```

## Async Behavior

Event listeners run through `task.spawn`, so multiple incoming Discord events can be handled at the same time. Shared variables are still shared state, so keep per-user or per-interaction values local whenever possible.
