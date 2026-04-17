--!strict

export type ColorResolvable = number | string

local Color = {}

Color.Colors = {
	Black = 0x000000,
	White = 0xFFFFFF,
	Blurple = 0x5865F2,
	Green = 0x57F287,
	Yellow = 0xFEE75C,
	Red = 0xED4245,
	Pink = 0xEB459E,
	DarkGray = 0x2B2D31,
}

local function assertColorRange(value: number): ()
	if value < 0 or value > 0xFFFFFF then
		error("color must be from 0x000000 to 0xFFFFFF", 3)
	end
end

function Color.Resolve(color: ColorResolvable): number
	if type(color) == "number" then
		assertColorRange(color)
		return color
	end

	if type(color) ~= "string" then
		error("color must be a number or hex string", 2)
	end

	local hex = string.gsub(color, "#", "")
	if not string.match(hex, "^[%x]+$") then
		error("hex color must contain only hexadecimal characters", 2)
	end

	if #hex ~= 6 then
		error("hex color must be exactly 6 characters, like #57F287", 2)
	end

	local value = tonumber(hex, 16)
	if value == nil then
		error("failed to parse hex color", 2)
	end

	assertColorRange(value)
	return value
end

return Color
