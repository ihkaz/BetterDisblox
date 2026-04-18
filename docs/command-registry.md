# Command Registry

`CommandRegistry` routes slash command interactions by command name.

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

## Register Slash Commands

`CommandRegistry` handles incoming interactions. Register slash commands with `client.Rest`.

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
```

## Handle Interactions

`handle` returns `true` when a registered command handler runs.

It returns `false` when the interaction is not a chat input command, the command name is missing, or the command is not registered.

```lua
client:On("INTERACTION_CREATE", function(interaction)
	local handled = registry:handle(interaction)
	if not handled then
		return
	end
end)
```

Handler errors are not hidden. If a command handler errors, the error is raised.
