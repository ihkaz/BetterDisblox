# Interaction API

## Properties

| Property | Description |
| --- | --- |
| `Id` | Interaction ID. |
| `Token` | Interaction token. |
| `ApplicationId` | Discord application ID. |
| `Type` | Raw interaction type. |
| `Data` | Raw interaction data. |
| `CommandName` | Slash command name. |
| `CustomId` | Component or modal custom ID. |
| `Values` | Select menu selected values. |
| `Options` | Slash command options. |
| `Raw` | Raw Discord interaction payload. |
| `Deferred` | Whether a defer method was called. |
| `Replied` | Whether a reply-like method was called. |
| `Ephemeral` | Whether the response was marked ephemeral. |

## Response Methods

| Method | Alias | Description |
| --- | --- | --- |
| `Reply(payload)` | `reply(payload)` | Create an interaction response. |
| `ReplyEphemeral(payload)` | `replyEphemeral(payload)` | Reply with ephemeral flag. |
| `DeferReply(ephemeral)` | `deferReply(ephemeral)` | Defer a slash command or modal response. |
| `EditReply(payload)` | `editReply(payload)` | Edit the original response. |
| `DeleteReply()` | `deleteReply()` | Delete the original response. |
| `FollowUp(payload)` | `followUp(payload)` | Create a followup message. |
| `ShowModal(modal)` | `showModal(modal)` | Open a modal. |
| `DeferUpdate()` | `deferUpdate()` | Defer a component update. |
| `Update(payload)` | `update(payload)` | Update the component message. |

## Type Guards

```lua
interaction:isChatInputCommand()
interaction:isMessageComponent()
interaction:isButton()
interaction:isStringSelectMenu()
interaction:isModalSubmit()
```

PascalCase aliases are available for all type guards.

## Option Helpers

```lua
interaction:GetOption("name")
interaction:GetString("name")
interaction:GetInteger("name")
interaction:GetBoolean("name")
interaction:GetTextInputValue("custom_id")
```
