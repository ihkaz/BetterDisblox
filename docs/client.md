# Client

`Client` owns the Gateway connection and exposes a REST client at `client.Rest`.

```lua
local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
})
```

## Options

| Name | Type | Description |
| --- | --- | --- |
| `Token` | `string` | Discord bot token. |
| `Intents` | `number` | Bitmask from `BetterDisblox.Intents`. |
| `GatewayUrl` | `string?` | Custom Gateway URL. |
| `RestBaseUrl` | `string?` | Custom Discord REST base URL. |
| `AutoReconnect` | `boolean?` | Enable Gateway reconnect. |
| `ReconnectDelay` | `number?` | Delay between reconnect attempts. |
| `MaxReconnectAttempts` | `number?` | Maximum reconnect attempts. |
| `SessionPersistence` | `boolean?` | Save Gateway resume data with filesystem APIs. |
| `SessionFolder` | `string?` | Folder used by session persistence. |
| `SessionFileName` | `string?` | File used by session persistence. |

## Methods

```lua
client:On("READY", function(data) end)
client:Once("READY", function(data) end)
client:SetPresence({
	status = "online",
	activities = {
		{
			name = "BetterDisblox",
			type = 0,
		},
	},
	afk = false,
	since = nil,
})
client:Login()
client:Destroy()
```

## Debug Logs

Enable console diagnostics before `client:Login()`:

```lua
client:EnableConsoleDebug()
client:Login()
```

This prints Gateway lifecycle events, close events, listener errors, and `READY` status. Use it when slash commands register successfully but command handlers do not run.

## Wrapped Events

`MESSAGE_CREATE` callbacks receive a `Message` wrapper.

`INTERACTION_CREATE` callbacks receive an `Interaction` wrapper.

Other events receive raw Discord Gateway data.
