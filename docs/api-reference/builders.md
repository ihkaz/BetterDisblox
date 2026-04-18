# Builders API

## SlashCommandBuilder

```lua
BetterDisblox.SlashCommandBuilder.new()
	:SetName("ping")
	:SetDescription("Replies with pong")
	:AddStringOption("text", "Text to send", true)
	:AddIntegerOption("count", "Count", false)
	:AddBooleanOption("silent", "Silent reply", false)
	:AddUserOption("user", "Target user", false)
	:AddChannelOption("channel", "Target channel", false)
	:AddRoleOption("role", "Target role", false)
	:Build()
```

## EmbedBuilder

Common methods:

```lua
SetTitle
SetDescription
SetColor
SetAuthor
SetFooter
SetImage
SetThumbnail
AddFields
SetTimestampNow
Build
```

## Component Builders

Classic components:

```lua
ActionRowBuilder
ButtonBuilder
StringSelectMenuBuilder
SelectMenuOptionBuilder
ModalBuilder
TextInputBuilder
```

Components v2:

```lua
TextDisplayBuilder
ContainerBuilder
SectionBuilder
SeparatorBuilder
ThumbnailBuilder
MediaGalleryBuilder
FileBuilder
```
