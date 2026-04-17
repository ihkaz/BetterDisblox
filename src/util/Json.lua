--!strict

export type Json = {
	Encode: (value: any) -> string,
	Decode: (value: string) -> any,
}

local Json = {}

local function getHttpService(): HttpService
	return game:GetService("HttpService")
end

function Json.Encode(value: any): string
	local success, result = pcall(function()
		return getHttpService():JSONEncode(value)
	end)

	if not success then
		error("Failed to encode JSON: " .. tostring(result), 2)
	end

	return result
end

function Json.Decode(value: string): any
	if type(value) ~= "string" then
		error("JSON value must be a string", 2)
	end

	local success, result = pcall(function()
		return getHttpService():JSONDecode(value)
	end)

	if not success then
		error("Failed to decode JSON: " .. tostring(result), 2)
	end

	return result
end

return Json
