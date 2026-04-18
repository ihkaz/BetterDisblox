# Client API

## Constructor

```lua
local client = BetterDisblox.Client.new(options)
```

## Options

```lua
{
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	GatewayUrl = nil,
	RestBaseUrl = nil,
	AutoReconnect = nil,
	ReconnectDelay = nil,
	MaxReconnectAttempts = nil,
	SessionPersistence = nil,
	SessionFolder = nil,
	SessionFileName = nil,
}
```

## Properties

| Property | Description |
| --- | --- |
| `Rest` | REST client instance. |

## Methods

| Method | Description |
| --- | --- |
| `On(eventName, callback)` | Register an event listener. |
| `Once(eventName, callback)` | Register a one-time event listener. |
| `EnableConsoleDebug()` | Print Gateway debug, close, error, and ready logs. |
| `Login()` | Connect to Discord Gateway. |
| `Destroy()` | Disconnect from Discord Gateway. |
| `SetPresence(presence)` | Send a presence update. |
