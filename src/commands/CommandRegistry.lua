--!strict

local Collection = require("../util/Collection")

export type CommandHandler = (interaction: any) -> any

export type CommandRegistry = {
	Register: (self: CommandRegistry, name: string, handler: CommandHandler) -> CommandRegistry,
	register: (self: CommandRegistry, name: string, handler: CommandHandler) -> CommandRegistry,
	Unregister: (self: CommandRegistry, name: string) -> boolean,
	unregister: (self: CommandRegistry, name: string) -> boolean,
	Get: (self: CommandRegistry, name: string) -> CommandHandler?,
	get: (self: CommandRegistry, name: string) -> CommandHandler?,
	Has: (self: CommandRegistry, name: string) -> boolean,
	has: (self: CommandRegistry, name: string) -> boolean,
	Clear: (self: CommandRegistry) -> (),
	clear: (self: CommandRegistry) -> (),
	Size: (self: CommandRegistry) -> number,
	size: (self: CommandRegistry) -> number,
	Handle: (self: CommandRegistry, interaction: any) -> boolean,
	handle: (self: CommandRegistry, interaction: any) -> boolean,
}

type CommandRegistryState = {
	commands: any,
}

local CommandRegistry = {}
CommandRegistry.__index = CommandRegistry

local function assertCommandName(name: string): ()
	if type(name) ~= "string" or not string.match(name, "^[%l%d_-]+$") then
		error("command name must use lowercase letters, numbers, underscores, or dashes", 3)
	end

	if #name < 1 or #name > 32 then
		error("command name must be 1 to 32 characters", 3)
	end
end

local function assertCommandHandler(handler: CommandHandler): ()
	if type(handler) ~= "function" then
		error("command handler must be a function", 3)
	end
end

local function assertInteraction(interaction: any): ()
	if type(interaction) ~= "table" or type(interaction.isChatInputCommand) ~= "function" then
		error("interaction must be a BetterDisblox Interaction", 3)
	end
end

function CommandRegistry.new(): CommandRegistry
	local self: CommandRegistryState = {
		commands = Collection.new(),
	}

	return (setmetatable(self, CommandRegistry) :: any) :: CommandRegistry
end

function CommandRegistry:Register(name: string, handler: CommandHandler): CommandRegistry
	assertCommandName(name)
	assertCommandHandler(handler)

	local state = self :: any
	state.commands:Set(name, handler)
	return self
end

function CommandRegistry:Unregister(name: string): boolean
	assertCommandName(name)
	local state = self :: any
	return state.commands:Delete(name)
end

function CommandRegistry:Get(name: string): CommandHandler?
	assertCommandName(name)
	local state = self :: any
	return state.commands:Get(name)
end

function CommandRegistry:Has(name: string): boolean
	assertCommandName(name)
	local state = self :: any
	return state.commands:Has(name)
end

function CommandRegistry:Clear(): ()
	local state = self :: any
	state.commands:Clear()
end

function CommandRegistry:Size(): number
	local state = self :: any
	return state.commands:Size()
end

function CommandRegistry:Handle(interaction: any): boolean
	assertInteraction(interaction)

	if not interaction:isChatInputCommand() then
		return false
	end

	local commandName = interaction.CommandName
	if type(commandName) ~= "string" or commandName == "" then
		return false
	end

	local handler = self:Get(commandName)
	if handler == nil then
		return false
	end

	handler(interaction)
	return true
end

CommandRegistry.register = CommandRegistry.Register
CommandRegistry.unregister = CommandRegistry.Unregister
CommandRegistry.get = CommandRegistry.Get
CommandRegistry.has = CommandRegistry.Has
CommandRegistry.clear = CommandRegistry.Clear
CommandRegistry.size = CommandRegistry.Size
CommandRegistry.handle = CommandRegistry.Handle

return CommandRegistry
