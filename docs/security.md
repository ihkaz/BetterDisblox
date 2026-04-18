# Security

Discord bot tokens are secrets.

Executor scripts run on the client. Anyone with access to the script can extract the token.

## Rules

- Never publish scripts containing a real bot token.
- Never commit a real token to GitHub.
- Use a private bot for testing.
- Rotate the token immediately if it was leaked.
- Use webhooks when you only need webhook messages.
- Use your own backend when sensitive operations must be exposed to other users.

## Safer Local Pattern

Keep token assignment separate from shared code:

```lua
local token = "BOT_TOKEN"

local client = BetterDisblox.Client.new({
	Token = token,
	Intents = BetterDisblox.Intents.Guilds,
})
```

This does not make the token safe for public scripts. It only keeps examples cleaner while testing privately.
