# BetterDisblox

BetterDisblox is a Discord Gateway and REST client for Roblox executor environments. It is built for executors that support UNC-style `request`, `WebSocket.connect`, and optional filesystem APIs.

The API is inspired by `discord.js`, but implemented in Luau and bundled with Darklua.

## Status

This project is early. It currently supports:

- Discord Gateway login, heartbeat, events, reconnect, and resume.
- Optional session persistence through UNC filesystem APIs.
- Discord REST message helpers.
- Application command registration helpers.
- Interaction response helpers.
- `EmbedBuilder`.
- `SlashCommandBuilder`.
- `ActionRowBuilder` and `ButtonBuilder`.
- `StringSelectMenuBuilder` and `SelectMenuOptionBuilder`.
- `ModalBuilder`, `TextInputBuilder`, and `TextInputStyle`.
- Components v2 foundation: `MessageFlags`, `TextDisplayBuilder`, and `ContainerBuilder`.
- discord.js-style `Message` and `Interaction` wrapper objects.

## Requirements

- Roblox executor with UNC `request(options)`.
- Roblox executor with UNC `WebSocket.connect(url)`.
- `HttpService` JSON support.
- Optional UNC filesystem APIs for `SessionPersistence`: `isfile`, `readfile`, `writefile`, `isfolder`, `makefolder`, `delfile`.
- Darklua for rebuilding the bundled file.

## Install

Use the bundled file:

```lua
local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()
```

## Build

```bash
darklua process src/init.lua dist/BetterDisblox.lua
```

## Basic Example

```lua
local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()

local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds
		+ BetterDisblox.Intents.GuildMessages
		+ BetterDisblox.Intents.MessageContent,
	SessionPersistence = true,
})

client:On("READY", function(data)
	print("Ready as " .. data.user.username)
	client:SetPresence({
		status = "online",
		activities = {
			{
				name = "BetterDisblox",
				type = 0,
			},
		},
		afk = false,
		since = nil,
	})
end)

client:On("MESSAGE_CREATE", function(message)
	if message.Content == "!ping" then
		message:Reply("pong")
	end
end)

client:Login()
```

## Slash Commands

```lua
local commands = {
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("ping")
		:SetDescription("Replies with pong")
		:Build(),
	BetterDisblox.SlashCommandBuilder.new()
		:SetName("say")
		:SetDescription("Replies with your text")
		:AddStringOption("text", "Text to send", true)
		:Build(),
}

client.Rest:BulkOverwriteGuildApplicationCommands("APPLICATION_ID", "GUILD_ID", commands)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type ~= 2 then
		return
	end

	if interaction.CommandName == "ping" then
		interaction:Reply("pong")
		return
	end

	if interaction.CommandName == "say" then
		interaction:Reply(interaction:GetString("text") or "")
	end
end)
```

## Buttons

```lua
local row = BetterDisblox.ActionRowBuilder.new()
	:AddComponents(
		BetterDisblox.ButtonBuilder.new()
			:SetCustomId("confirm")
			:SetLabel("Confirm")
			:SetStyle(BetterDisblox.ButtonStyle.Success),
		BetterDisblox.ButtonBuilder.new()
			:SetCustomId("cancel")
			:SetLabel("Cancel")
			:SetStyle(BetterDisblox.ButtonStyle.Danger)
	)
	:Build()

interaction:Reply({
	content = "Choose an action",
	components = { row },
})

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type ~= 3 then
		return
	end

	if interaction.CustomId == "confirm" then
		interaction:ReplyEphemeral("Confirmed")
		return
	end

	if interaction.CustomId == "cancel" then
		interaction:ReplyEphemeral("Cancelled")
	end
end)
```

## String Select Menus

```lua
local menu = BetterDisblox.StringSelectMenuBuilder.new()
	:SetCustomId("choose_color")
	:SetPlaceholder("Choose a color")
	:SetMinValues(1)
	:SetMaxValues(1)
	:AddOptions(
		BetterDisblox.SelectMenuOptionBuilder.new()
			:SetLabel("Red")
			:SetValue("red")
			:SetDescription("Pick red"),
		BetterDisblox.SelectMenuOptionBuilder.new()
			:SetLabel("Green")
			:SetValue("green")
			:SetDescription("Pick green")
	)
	:Build()

local row = BetterDisblox.ActionRowBuilder.new()
	:AddComponents(menu)
	:Build()

interaction:Reply({
	content = "Pick one",
	components = { row },
})

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type ~= 3 or interaction.CustomId ~= "choose_color" then
		return
	end

	interaction:ReplyEphemeral("You picked " .. tostring(interaction.Values[1]))
end)
```

## Modals

```lua
local modal = BetterDisblox.ModalBuilder.new()
	:SetCustomId("feedback_modal")
	:SetTitle("Feedback")
	:AddComponents(
		BetterDisblox.ActionRowBuilder.new()
			:AddComponents(
				BetterDisblox.TextInputBuilder.new()
					:SetCustomId("feedback_text")
					:SetLabel("Your feedback")
					:SetStyle(BetterDisblox.TextInputStyle.Paragraph)
					:SetRequired(true)
			)
	)

interaction:ShowModal(modal)

client:On("INTERACTION_CREATE", function(interaction)
	if interaction.Type ~= 5 or interaction.CustomId ~= "feedback_modal" then
		return
	end

	local feedback = interaction:GetTextInputValue("feedback_text") or ""
	interaction:ReplyEphemeral("Thanks: " .. feedback)
end)
```

## Components v2

```lua
local container = BetterDisblox.ContainerBuilder.new()
	:SetAccentColor(0x57F287)
	:AddComponents(
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("## BetterDisblox"),
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("Components v2 from a Roblox executor.")
	)
	:Build()

interaction:Reply({
	flags = BetterDisblox.MessageFlags.IsComponentsV2,
	components = { container },
})
```

## Session Persistence

Enable Gateway resume persistence:

```lua
local client = BetterDisblox.Client.new({
	Token = "BOT_TOKEN",
	Intents = BetterDisblox.Intents.Guilds,
	SessionPersistence = true,
	SessionFolder = "BetterDisblox",
	SessionFileName = "session.json",
})
```

The session file stores only Gateway resume data. Do not store bot tokens in executor files.

## Security

Never publish scripts containing a Discord bot token. Executor scripts are client-side and tokens can be extracted. Use this privately or route sensitive operations through your own backend.

## License

MIT
