# RestClient API

The REST client is available from `client.Rest`.

```lua
local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
})

local me = client.Rest:GetCurrentUser()
```

## Low-Level Request

```lua
client.Rest:Request("GET", "/users/@me", nil)
```

`Request` sends an authenticated Discord REST request to the configured REST base URL.

## Users

```lua
client.Rest:GetCurrentUser()
client.Rest:GetUser("USER_ID")
```

## Channels

```lua
client.Rest:GetChannel("CHANNEL_ID")
client.Rest:ModifyChannel("CHANNEL_ID", {
	name = "new-name",
})
```

## Messages

```lua
client.Rest:GetChannelMessages("CHANNEL_ID", {
	limit = 10,
})

client.Rest:GetMessage("CHANNEL_ID", "MESSAGE_ID")

client.Rest:CreateMessage("CHANNEL_ID", {
	content = "Hello",
})

client.Rest:EditMessage("CHANNEL_ID", "MESSAGE_ID", {
	content = "Edited",
})

client.Rest:DeleteMessage("CHANNEL_ID", "MESSAGE_ID")
client.Rest:TriggerTyping("CHANNEL_ID")
```

String payloads are accepted by high-level message wrappers like `message:Reply`, but REST message methods expect Discord message payload tables.

## Guilds

```lua
client.Rest:GetGuild("GUILD_ID")
client.Rest:GetGuildChannels("GUILD_ID")
client.Rest:GetGuildMember("GUILD_ID", "USER_ID")
client.Rest:GetGuildRoles("GUILD_ID")
```

## Application Commands

```lua
client.Rest:CreateGlobalApplicationCommand("APPLICATION_ID", command)
client.Rest:BulkOverwriteGlobalApplicationCommands("APPLICATION_ID", commands)

client.Rest:CreateGuildApplicationCommand("APPLICATION_ID", "GUILD_ID", command)
client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)
```

Guild command updates are usually faster for testing. Global command updates can take longer to appear in Discord.

## Interaction Internals

Most users should call methods on the `Interaction` wrapper instead of calling these directly.

```lua
client.Rest:CreateInteractionResponse("INTERACTION_ID", "INTERACTION_TOKEN", payload)
client.Rest:EditOriginalInteractionResponse("APPLICATION_ID", "INTERACTION_TOKEN", payload)
client.Rest:DeleteOriginalInteractionResponse("APPLICATION_ID", "INTERACTION_TOKEN")
client.Rest:CreateFollowupMessage("APPLICATION_ID", "INTERACTION_TOKEN", payload)
```
