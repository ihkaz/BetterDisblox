# WebhookClient API

## Constructor

```lua
local webhook = BetterDisblox.WebhookClient.new("WEBHOOK_URL", {
	Wait = true,
	Username = "BetterDisblox",
	AvatarUrl = "https://example.com/avatar.png",
	ThreadId = "THREAD_ID",
})
```

## Methods

```lua
webhook:Send(payload, options)
webhook:EditMessage(messageId, payload, options)
webhook:DeleteMessage(messageId, options)
```

## Options

| Name | Type | Description |
| --- | --- | --- |
| `Wait` | `boolean?` | Return the created message when sending. |
| `Username` | `string?` | Override webhook username. |
| `AvatarUrl` | `string?` | Override webhook avatar. |
| `ThreadId` | `string?` | Target a thread. |
