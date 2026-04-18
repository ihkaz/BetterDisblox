# Builders

Builders create Discord payload tables.

## SlashCommandBuilder

```lua
local command = BetterDisblox.SlashCommandBuilder.new()
	:SetName("say")
	:SetDescription("Replies with your text")
	:AddStringOption("text", "Text to send", true)
	:Build()
```

Register commands with REST:

```lua
client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", {
	command,
})
```

## EmbedBuilder

```lua
local embed = BetterDisblox.EmbedBuilder.new()
	:SetTitle("BetterDisblox")
	:SetDescription("Embed from Roblox executor")
	:SetColor("#57F287")
	:SetFooter({
		text = "Powered by BetterDisblox",
	})
	:SetTimestampNow()
	:Build()
```

Send it:

```lua
client.Rest:CreateMessage("CHANNEL_ID", {
	embeds = { embed },
})
```

## ButtonBuilder

```lua
local row = BetterDisblox.ActionRowBuilder.new()
	:AddComponents(
		BetterDisblox.ButtonBuilder.new()
			:SetCustomId("confirm")
			:SetLabel("Confirm")
			:SetSuccess()
	)
	:Build()
```

## StringSelectMenuBuilder

```lua
local menu = BetterDisblox.StringSelectMenuBuilder.new()
	:SetCustomId("choose_color")
	:SetPlaceholder("Choose a color")
	:SetMinValues(1)
	:SetMaxValues(1)
	:AddOptions(
		BetterDisblox.SelectMenuOptionBuilder.new()
			:SetLabel("Green")
			:SetValue("green")
	)
	:Build()
```
