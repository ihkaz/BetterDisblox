# CommandRegistry API

## Constructor

```lua
local registry = BetterDisblox.CommandRegistry.new()
```

## Register

```lua
registry:register("ping", function(interaction)
	interaction:reply("pong")
end)
```

Command names must use lowercase letters, numbers, underscores, or dashes. Names must be 1 to 32 characters.

## Methods

| Method | Description |
| --- | --- |
| `register(name, handler)` | Store a command handler. |
| `unregister(name)` | Delete a command handler and return whether it existed. |
| `get(name)` | Return a command handler or `nil`. |
| `has(name)` | Return whether a command handler exists. |
| `clear()` | Remove all command handlers. |
| `size()` | Return command handler count. |
| `handle(interaction)` | Run the matching handler for a chat input command interaction. |

PascalCase aliases are available for all methods.

## Handle Return Value

```lua
local handled = registry:handle(interaction)
```

`handle` returns `true` when a registered command handler runs.

`handle` returns `false` when:

- the interaction is not a chat input command
- the command name is missing
- the command is not registered
