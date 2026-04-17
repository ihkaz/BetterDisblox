--!strict

local Json = require("../util/Json")

export type RequestOptions = {
	Url: string,
	Method: string,
	Headers: { [string]: string },
	Body: string?,
}

export type HttpResponse = {
	StatusCode: number,
	Body: string,
	Headers: { [string]: string },
}

local Http = {}

local function getRequestFunction(): (RequestOptions) -> HttpResponse
	local requestFunction = (getgenv and getgenv().request) or request or http_request or (http and http.request)

	if type(requestFunction) ~= "function" then
		error("UNC request function is unavailable. This executor must support request(options).", 2)
	end

	return requestFunction
end

function Http.Request(options: RequestOptions): HttpResponse
	if type(options.Url) ~= "string" or options.Url == "" then
		error("Request Url must be a non-empty string", 2)
	end

	if type(options.Method) ~= "string" or options.Method == "" then
		error("Request Method must be a non-empty string", 2)
	end

	local response = getRequestFunction()(options)

	if type(response) ~= "table" then
		error("request(options) returned a non-table response", 2)
	end

	if type(response.StatusCode) ~= "number" then
		error("request(options) response is missing numeric StatusCode", 2)
	end

	if type(response.Body) ~= "string" then
		error("request(options) response is missing string Body", 2)
	end

	return response
end

function Http.JsonRequest(method: string, url: string, headers: { [string]: string }, body: any): HttpResponse
	local requestHeaders: { [string]: string } = {}
	for key, value in pairs(headers) do
		requestHeaders[key] = value
	end

	requestHeaders["Content-Type"] = "application/json"

	local encodedBody: string? = nil
	if body ~= nil then
		encodedBody = Json.Encode(body)
	end

	return Http.Request({
		Url = url,
		Method = method,
		Headers = requestHeaders,
		Body = encodedBody,
	})
end

return Http
