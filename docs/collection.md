# Collection

`Collection` is a keyed utility for command registries, caches, and local state.

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

## Methods

```lua
collection:set(key, value)
collection:get(key)
collection:has(key)
collection:delete(key)
collection:clear()
collection:size()
collection:keys()
collection:values()
collection:entries()
collection:first()
collection:find(function(value, key) return true end)
collection:filter(function(value, key) return true end)
collection:map(function(value, key) return value end)
collection:forEach(function(value, key) end)
```

PascalCase aliases are also available:

```lua
collection:Set("ping", handler)
collection:Get("ping")
collection:Size()
```
