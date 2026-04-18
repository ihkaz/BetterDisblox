# Installation

Most executor users should load the bundled file directly from GitHub:

```lua
local BetterDisblox = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/BetterDisblox/main/dist/BetterDisblox.lua"))()
```

## Requirements

- Roblox executor with UNC `request(options)`.
- Roblox executor with UNC `WebSocket.connect(url)`.
- `HttpService` JSON support.
- Optional UNC filesystem APIs for session persistence: `isfile`, `readfile`, `writefile`, `isfolder`, `makefolder`, and `delfile`.

## Local Bundle

If you saved the bundle locally, load it from the executor filesystem:

```lua
local BetterDisblox = loadstring(readfile("dist/BetterDisblox.lua"))()
```

## Build From Source

Install Darklua and run:

```bash
darklua process src/init.lua dist/BetterDisblox.lua
```

The published bundle path is:

```text
dist/BetterDisblox.lua
```
