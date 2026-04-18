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
message:Reply("pong")

message:Edit({
	content = "Edited",
})

message:Delete()
```
