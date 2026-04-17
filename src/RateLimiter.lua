--!strict

export type RateLimitState = {
	unlockedAt: number,
}

export type RateLimiter = {
	Wait: (self: RateLimiter, routeKey: string) -> (),
	Update: (self: RateLimiter, routeKey: string, statusCode: number, headers: { [string]: string }, body: string) -> (),
}

local RateLimiter = {}
RateLimiter.__index = RateLimiter

function RateLimiter.new(): RateLimiter
	local self = {
		buckets = {} :: { [string]: RateLimitState },
	}

	return (setmetatable(self, RateLimiter) :: any) :: RateLimiter
end

local function parseRetryAfter(headers: { [string]: string }, body: string): number
	local retryHeader = headers["Retry-After"] or headers["retry-after"]
	if retryHeader ~= nil then
		local retrySeconds = tonumber(retryHeader)
		if retrySeconds ~= nil then
			return retrySeconds
		end
	end

	local success, decoded = pcall(function()
		return game:GetService("HttpService"):JSONDecode(body)
	end)

	if success and type(decoded) == "table" and type(decoded.retry_after) == "number" then
		return decoded.retry_after
	end

	return 1
end

function RateLimiter:Wait(routeKey: string): ()
	if type(routeKey) ~= "string" or routeKey == "" then
		error("routeKey must be a non-empty string", 2)
	end

	local state = (self :: any).buckets[routeKey]
	if state == nil then
		return
	end

	local delaySeconds = state.unlockedAt - os.clock()
	if delaySeconds > 0 then
		task.wait(delaySeconds)
	end
end

function RateLimiter:Update(routeKey: string, statusCode: number, headers: { [string]: string }, body: string): ()
	if type(routeKey) ~= "string" or routeKey == "" then
		error("routeKey must be a non-empty string", 2)
	end

	if statusCode ~= 429 then
		return
	end

	local retryAfter = parseRetryAfter(headers, body)
	local state = self :: any
	state.buckets[routeKey] = {
		unlockedAt = os.clock() + retryAfter,
	}
end

return RateLimiter
