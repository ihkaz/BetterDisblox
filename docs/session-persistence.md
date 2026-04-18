# Session Persistence

Session persistence stores Gateway resume data so the client can resume after reconnects.

```lua
local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
	SessionFolder = "BetterDisblox",
	SessionFileName = "session.json",
})
```

## Stored Data

The session file stores Gateway resume data only.

Do not store bot tokens in executor files.

## Required Filesystem APIs

Session persistence needs these UNC APIs:

- `isfile`
- `readfile`
- `writefile`
- `isfolder`
- `makefolder`
- `delfile`

If the executor does not support these APIs, keep `SessionPersistence` disabled.
