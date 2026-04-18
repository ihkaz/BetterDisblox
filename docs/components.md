# Components

BetterDisblox supports classic message components and Components v2 payloads.

## Classic Components

Classic components use action rows.

```lua
local row = BetterDisblox.ActionRowBuilder.new()
	:AddComponents(
		BetterDisblox.ButtonBuilder.new()
			:SetCustomId("confirm")
			:SetLabel("Confirm")
			:SetSuccess(),
		BetterDisblox.ButtonBuilder.new()
			:SetCustomId("cancel")
			:SetLabel("Cancel")
			:SetDanger()
	)
	:Build()

interaction:reply({
	content = "Choose an action",
	components = { row },
})
```

## Components v2

Components v2 requires the `IsComponentsV2` message flag.

When `IsComponentsV2` is set, do not include `content`, `embeds`, `stickers`, or `poll` in the same message payload. Use `TextDisplayBuilder` and other Components v2 builders instead.

```lua
local container = BetterDisblox.ContainerBuilder.new()
	:SetGreen()
	:AddComponents(
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("## BetterDisblox"),
		BetterDisblox.SeparatorBuilder.new()
			:SetSpacing(BetterDisblox.SeparatorSpacing.Large),
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("Built with BetterDisblox.")
	)
	:Build()

interaction:reply({
	flags = BetterDisblox.MessageFlags.IsComponentsV2,
	components = { container },
})
```

## Components v2 Builders

- `TextDisplayBuilder`
- `ContainerBuilder`
- `SectionBuilder`
- `SeparatorBuilder`
- `ThumbnailBuilder`
- `MediaGalleryBuilder`
- `FileBuilder`
