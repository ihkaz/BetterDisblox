# Intents API

Gateway intents control which events Discord sends to the bot.

```lua
local intents = BetterDisblox.Intents.Guilds
	+ BetterDisblox.Intents.GuildMessages
	+ BetterDisblox.Intents.MessageContent

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = intents,
})
```

## Available Intents

| Name | Value |
| --- | ---: |
| `Guilds` | `1` |
| `GuildMembers` | `2` |
| `GuildModeration` | `4` |
| `GuildEmojisAndStickers` | `8` |
| `GuildIntegrations` | `16` |
| `GuildWebhooks` | `32` |
| `GuildInvites` | `64` |
| `GuildVoiceStates` | `128` |
| `GuildPresences` | `256` |
| `GuildMessages` | `512` |
| `GuildMessageReactions` | `1024` |
| `GuildMessageTyping` | `2048` |
| `DirectMessages` | `4096` |
| `DirectMessageReactions` | `8192` |
| `DirectMessageTyping` | `16384` |
| `MessageContent` | `32768` |
| `GuildScheduledEvents` | `65536` |
| `AutoModerationConfiguration` | `1048576` |
| `AutoModerationExecution` | `2097152` |

## Common Combinations

Slash command bot:

```lua
BetterDisblox.Intents.Guilds
```

Guild message bot:

```lua
BetterDisblox.Intents.Guilds
	+ BetterDisblox.Intents.GuildMessages
	+ BetterDisblox.Intents.MessageContent
```

Direct message bot:

```lua
BetterDisblox.Intents.DirectMessages
	+ BetterDisblox.Intents.MessageContent
```

Some privileged intents must also be enabled in the Discord Developer Portal.
