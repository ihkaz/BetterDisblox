# REST

The REST client is available at `client.Rest`.

## Messages

```lua
client.Rest:CreateMessage("CHANNEL_ID", "Hello")

local message = client.Rest:GetMessage("CHANNEL_ID", "MESSAGE_ID")

client.Rest:EditMessage("CHANNEL_ID", "MESSAGE_ID", {
	content = "Edited",
})

client.Rest:DeleteMessage("CHANNEL_ID", "MESSAGE_ID")
```

## Channels And Guilds

```lua
local channel = client.Rest:GetChannel("CHANNEL_ID")

local messages = client.Rest:GetChannelMessages("CHANNEL_ID", {
	limit = 10,
})

client.Rest:TriggerTyping("CHANNEL_ID")

local guild = client.Rest:GetGuild("GUILD_ID")
local channels = client.Rest:GetGuildChannels("GUILD_ID")
local member = client.Rest:GetGuildMember("GUILD_ID", "USER_ID")
local roles = client.Rest:GetGuildRoles("GUILD_ID")
```

## Users

```lua
local me = client.Rest:GetCurrentUser()
local user = client.Rest:GetUser("USER_ID")
```

## Application Commands

```lua
client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)
client.Rest:BulkOverwriteGlobalApplicationCommands("APPLICATION_ID", commands)
```
