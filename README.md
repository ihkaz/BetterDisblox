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
- Components v2 foundation: `MessageFlags`, `TextDisplayBuilder`, `ContainerBuilder`, `SectionBuilder`, `SeparatorBuilder`, `ThumbnailBuilder`, `MediaGalleryBuilder`, and `FileBuilder`.
- `WebhookClient` for Discord webhooks without Gateway/WebSocket.
- Color resolving for `0xRRGGBB`, `"#RRGGBB"`, and `"RRGGBB"`.
- discord.js-style `Message` and `Interaction` wrapper objects.
- `CommandRegistry` for slash command routing.

## Requirements

- Roblox executor with UNC `request(options)`.
- Roblox executor with UNC `WebSocket.connect(url)`.
- `HttpService` JSON support.
- Optional UNC filesystem APIs for `SessionPersistence`: `isfile`, `readfile`, `writefile`, `isfolder`, `makefolder`, `delfile`.
- Darklua for rebuilding the bundled file.

## Install

Most executor users can load the bundled file directly from GitHub:

```lua
local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()
```

If you already saved the bundle locally, load it from the executor filesystem:

```lua
local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()
```

## Build

```bash
darklua process src/init.lua dist/BetterDisblox.lua
```

## Source Tree

```text
src/
  init.lua
  client/
  gateway/
  rest/
  structures/
  builders/
    components/
    components_v2/
  storage/
  util/
```

## Basic Example

```lua
local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()

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

## Colors

Colors can be numbers or hex strings:

```lua
BetterDisblox.EmbedBuilder.new()
	:SetTitle("Colors")
	:SetDescription("Hex strings are supported")
	:SetColor("#57F287")
	:SetAuthor({
		name = "ihkaz",
	})
	:SetFooter({
		text = "Powered by BetterDisblox",
	})
	:AddFields(
		{ name = "Style", value = "EmbedBuilder", inline = true },
		{ name = "Color", value = "#57F287", inline = true }
	)
	:SetTimestampNow()
	:Build()

BetterDisblox.ContainerBuilder.new()
	:SetBlurple()
	:AddComponents(
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("Discord blurple")
	)
	:Build()
```

Built-in color constants:

```lua
BetterDisblox.Colors.Blurple
BetterDisblox.Colors.Green
BetterDisblox.Colors.Yellow
BetterDisblox.Colors.Red
BetterDisblox.Colors.Pink
BetterDisblox.Colors.DarkGray
BetterDisblox.Colors.White
BetterDisblox.Colors.Black
```

## Collection

Use `Collection` for command registries, caches, or any keyed data:

```lua
local commands = BetterDisblox.Collection.new()

commands:set("ping", function(interaction)
	interaction:reply("pong")
end)

client:On("INTERACTION_CREATE", function(interaction)
	if not interaction:isChatInputCommand() then
		return
	end

	local command = commands:get(interaction.CommandName)
	if command == nil then
		return
	end

	command(interaction)
end)
```

Available methods include `set`, `get`, `has`, `delete`, `clear`, `size`, `keys`, `values`, `entries`, `first`, `find`, `filter`, `map`, and `forEach`. PascalCase aliases are also available.

## Command Registry

Use `CommandRegistry` to route slash commands by name:

```lua
local registry = BetterDisblox.CommandRegistry.new()

registry:register("ping", function(interaction)
	interaction:reply("pong")
end)

registry:register("say", function(interaction)
	interaction:reply(interaction:GetString("text") or "")
end)

client:On("INTERACTION_CREATE", function(interaction)
	registry:handle(interaction)
end)
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
	if not interaction:IsChatInputCommand() then
		return
	end

	if interaction.CommandName == "ping" then
		interaction:reply("pong")
		return
	end

	if interaction.CommandName == "say" then
		interaction:reply(interaction:GetString("text") or "")
	end
end)
```

Interaction methods use both PascalCase and discord.js-style camelCase names:

```lua
client:On("INTERACTION_CREATE", function(interaction)
	if interaction:isChatInputCommand() and interaction.CommandName == "slow" then
		interaction:deferReply(false)
		interaction:editReply("Done")
		return
	end

	if interaction:isButton() and interaction.CustomId == "refresh" then
		interaction:deferUpdate()
		interaction:editReply("Refreshed")
		return
	end

	if interaction:isStringSelectMenu() then
		interaction:replyEphemeral("Selected: " .. tostring(interaction.Values[1]))
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
			:SetSuccess(),
		BetterDisblox.ButtonBuilder.new()
			:SetCustomId("cancel")
			:SetLabel("Cancel")
			:SetDanger()
	)
	:Build()

interaction:Reply({
	content = "Choose an action",
	components = { row },
})

client:On("INTERACTION_CREATE", function(interaction)
	if not interaction:IsMessageComponent() then
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
	if not interaction:IsStringSelectMenu() or interaction.CustomId ~= "choose_color" then
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
	if not interaction:IsModalSubmit() or interaction.CustomId ~= "feedback_modal" then
		return
	end

	local feedback = interaction:GetTextInputValue("feedback_text") or ""
	interaction:ReplyEphemeral("Thanks: " .. feedback)
end)
```

## Components v2

```lua
local container = BetterDisblox.ContainerBuilder.new()
	:SetGreen()
	:AddComponents(
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("## BetterDisblox"),

		BetterDisblox.SeparatorBuilder.new()
			:SetSpacing(BetterDisblox.SeparatorSpacing.Large),

		BetterDisblox.SectionBuilder.new()
			:AddComponents(
				BetterDisblox.TextDisplayBuilder.new()
					:SetContent("Components v2 from a Roblox executor.")
			)
			:SetAccessory(
				BetterDisblox.ThumbnailBuilder.new()
					:SetUrl("https://example.com/avatar.png")
					:SetDescription("Avatar")
			),

		BetterDisblox.MediaGalleryBuilder.new()
			:AddItems({
				url = "https://example.com/banner.png",
				description = "Banner",
			}),

		BetterDisblox.FileBuilder.new()
			:SetUrl("attachment://guide.txt"),

		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("Built with BetterDisblox.")
	)
	:Build()

interaction:Reply({
	flags = BetterDisblox.MessageFlags.IsComponentsV2,
	components = { container },
})
```

## Webhooks

```lua
local webhook = BetterDisblox.WebhookClient.new("WEBHOOK_URL", {
	Wait = true,
	Username = "BetterDisblox",
	AvatarUrl = "https://example.com/avatar.png",
})

local message = webhook:Send({
	content = "Hello from BetterDisblox",
	embeds = {
		BetterDisblox.EmbedBuilder.new()
			:SetTitle("Webhook")
			:SetDescription("No Gateway or bot token required.")
			:SetColor("#57F287")
			:SetFooter({
				text = "Powered by BetterDisblox",
			})
			:SetTimestampNow()
			:Build(),
	},
})

if message ~= nil then
	webhook:EditMessage(message.id, "Edited webhook message", {
		ThreadId = "THREAD_ID",
	})
end
```

## REST Helpers

```lua
local me = client.Rest:GetCurrentUser()
local channel = client.Rest:GetChannel("CHANNEL_ID")
local messages = client.Rest:GetChannelMessages("CHANNEL_ID", {
	limit = 10,
})

client.Rest:TriggerTyping("CHANNEL_ID")

local guild = client.Rest:GetGuild("GUILD_ID")
local channels = client.Rest:GetGuildChannels("GUILD_ID")
local roles = client.Rest:GetGuildRoles("GUILD_ID")
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
