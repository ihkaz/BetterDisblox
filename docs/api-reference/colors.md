# Colors API

BetterDisblox accepts Discord colors as numbers or hex strings.

```lua
BetterDisblox.Color.Resolve(0x57F287)
BetterDisblox.Color.Resolve("#57F287")
BetterDisblox.Color.Resolve("57F287")
```

All values resolve to a number from `0x000000` to `0xFFFFFF`.

## Built-In Colors

```lua
BetterDisblox.Colors.Black
BetterDisblox.Colors.White
BetterDisblox.Colors.Blurple
BetterDisblox.Colors.Green
BetterDisblox.Colors.Yellow
BetterDisblox.Colors.Red
BetterDisblox.Colors.Pink
BetterDisblox.Colors.DarkGray
```

## Embed Color

```lua
local embed = BetterDisblox.EmbedBuilder.new()
	:SetTitle("Color")
	:SetColor("#57F287")
	:Build()
```

## Components v2 Color

```lua
local container = BetterDisblox.ContainerBuilder.new()
	:SetAccentColor("#5865F2")
	:AddComponents(
		BetterDisblox.TextDisplayBuilder.new()
			:SetContent("Colored container")
	)
	:Build()
```

Container shortcut methods are also available:

```lua
BetterDisblox.ContainerBuilder.new():SetBlurple()
BetterDisblox.ContainerBuilder.new():SetGreen()
BetterDisblox.ContainerBuilder.new():SetYellow()
BetterDisblox.ContainerBuilder.new():SetRed()
BetterDisblox.ContainerBuilder.new():SetPink()
BetterDisblox.ContainerBuilder.new():SetDarkGray()
```

## Errors

Invalid colors raise explicit errors:

```lua
BetterDisblox.Color.Resolve("#GGGGGG")
BetterDisblox.Color.Resolve("#123")
BetterDisblox.Color.Resolve(0x1000000)
```
