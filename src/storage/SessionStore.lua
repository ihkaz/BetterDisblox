--!strict

local Json = require("../util/Json")

export type GatewaySession = {
	sessionId: string?,
	sequence: number?,
	resumeGatewayUrl: string?,
}

export type SessionStore = {
	Load: (self: SessionStore) -> GatewaySession?,
	Save: (self: SessionStore, session: GatewaySession) -> (),
	Clear: (self: SessionStore) -> (),
}

local SessionStore = {}
SessionStore.__index = SessionStore

local DEFAULT_FOLDER = "BetterDisblox"
local DEFAULT_FILE_NAME = "session.json"

local function getFilePath(folder: string, fileName: string): string
	return folder .. "/" .. fileName
end

local function assertFilesystemAvailable(): ()
	if type(isfile) ~= "function" then
		error("UNC isfile function is unavailable", 3)
	end

	if type(readfile) ~= "function" then
		error("UNC readfile function is unavailable", 3)
	end

	if type(writefile) ~= "function" then
		error("UNC writefile function is unavailable", 3)
	end

	if type(isfolder) ~= "function" then
		error("UNC isfolder function is unavailable", 3)
	end

	if type(makefolder) ~= "function" then
		error("UNC makefolder function is unavailable", 3)
	end
end

function SessionStore.new(folder: string?, fileName: string?): SessionStore
	local resolvedFolder = folder
	if resolvedFolder == nil then
		resolvedFolder = DEFAULT_FOLDER
	end

	local resolvedFileName = fileName
	if resolvedFileName == nil then
		resolvedFileName = DEFAULT_FILE_NAME
	end

	local self = {
		folder = resolvedFolder,
		fileName = resolvedFileName,
		filePath = getFilePath(resolvedFolder, resolvedFileName),
	}

	return (setmetatable(self, SessionStore) :: any) :: SessionStore
end

function SessionStore:Load(): GatewaySession?
	assertFilesystemAvailable()

	local state = self :: any
	if not isfile(state.filePath) then
		return nil
	end

	local decoded = Json.Decode(readfile(state.filePath))
	if type(decoded) ~= "table" then
		error("Saved BetterDisblox session file did not contain a JSON object", 2)
	end

	return {
		sessionId = decoded.sessionId,
		sequence = decoded.sequence,
		resumeGatewayUrl = decoded.resumeGatewayUrl,
	}
end

function SessionStore:Save(session: GatewaySession): ()
	assertFilesystemAvailable()

	local state = self :: any
	if not isfolder(state.folder) then
		makefolder(state.folder)
	end

	writefile(state.filePath, Json.Encode({
		sessionId = session.sessionId,
		sequence = session.sequence,
		resumeGatewayUrl = session.resumeGatewayUrl,
	}))
end

function SessionStore:Clear(): ()
	assertFilesystemAvailable()

	local state = self :: any
	if type(delfile) ~= "function" then
		error("UNC delfile function is unavailable", 2)
	end

	if isfile(state.filePath) then
		delfile(state.filePath)
	end
end

return SessionStore
