# WebhookClient API

## Constructor

```lua
local webhook = BetterDisblox.WebhookClient.new("WEBHOOK_URL", {
	Wait = true,
	Username = "BetterDisblox",
	AvatarUrl = "https://example.com/avatar.png",
	ThreadId = "THREAD_ID",
	WithComponents = true,
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
| `WithComponents` | `boolean?` | Force `with_components=true` on webhook requests. |

`with_components=true` is added automatically when a webhook send/edit payload includes `components`.
