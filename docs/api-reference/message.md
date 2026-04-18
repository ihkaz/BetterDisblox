# Message API

`MESSAGE_CREATE` handlers receive a `Message` wrapper.

## Properties

| Property | Description |
| --- | --- |
| `Id` | Message ID. |
| `ChannelId` | Channel ID. |
| `GuildId` | Guild ID, when present. |
| `Author` | Raw Discord author object. |
| `Content` | Message content. |
| `Raw` | Raw Discord message payload. |

## Methods

```lua
message:reply("pong")

message:edit({
	content = "Edited",
})

message:delete()
```

PascalCase aliases are also available:

```lua
message:Reply("pong")
message:Edit("Edited")
message:Delete()
```
