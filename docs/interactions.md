# Interactions

Interactions are wrapped into `Interaction` objects when using:

```lua
client:On("INTERACTION_CREATE", function(interaction)
end)
```

## Slash Commands

```lua
client:On("INTERACTION_CREATE", function(interaction)
	if not interaction:isChatInputCommand() then
		return
	end

	if interaction.CommandName == "ping" then
		interaction:reply("pong")
	end
end)
```

## Reply, Defer, Edit

```lua
client:On("INTERACTION_CREATE", function(interaction)
	if interaction:isChatInputCommand() and interaction.CommandName == "slow" then
		interaction:deferReply(false)
		task.wait(2)
		interaction:editReply("Done")
	end
end)
```

Use `true` for ephemeral deferred replies:

```lua
interaction:deferReply(true)
interaction:editReply("Only you can see this")
```

## Buttons And Select Menus

```lua
client:On("INTERACTION_CREATE", function(interaction)
	if interaction:isButton() and interaction.CustomId == "confirm" then
		interaction:replyEphemeral("Confirmed")
		return
	end

	if interaction:isStringSelectMenu() then
		interaction:replyEphemeral("Selected: " .. tostring(interaction.Values[1]))
	end
end)
```

## Component Updates

Use `deferUpdate` or `update` for message component interactions.

```lua
if interaction:isButton() and interaction.CustomId == "refresh" then
	interaction:update({
		content = "Refreshed",
		components = {},
	})
end
```

## Modals

```lua
interaction:showModal(
	BetterDisblox.ModalBuilder.new()
		:SetCustomId("feedback_modal")
		:SetTitle("Feedback")
		:AddComponents(
			BetterDisblox.ActionRowBuilder.new()
				:AddComponents(
					BetterDisblox.TextInputBuilder.new()
						:SetCustomId("feedback_text")
						:SetLabel("Feedback")
						:SetStyle(BetterDisblox.TextInputStyle.Paragraph)
						:SetRequired(true)
				)
		)
)
```

Read submitted text values:

```lua
if interaction:isModalSubmit() and interaction.CustomId == "feedback_modal" then
	local feedback = interaction:GetTextInputValue("feedback_text") or ""
	interaction:replyEphemeral("Thanks: " .. feedback)
end
```
