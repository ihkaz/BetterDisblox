--!strict

export type Entry<K, V> = {
	Key: K,
	Value: V,
}

export type Collection<K, V> = {
	Set: (self: Collection<K, V>, key: K, value: V) -> Collection<K, V>,
	set: (self: Collection<K, V>, key: K, value: V) -> Collection<K, V>,
	Get: (self: Collection<K, V>, key: K) -> V?,
	get: (self: Collection<K, V>, key: K) -> V?,
	Has: (self: Collection<K, V>, key: K) -> boolean,
	has: (self: Collection<K, V>, key: K) -> boolean,
	Delete: (self: Collection<K, V>, key: K) -> boolean,
	delete: (self: Collection<K, V>, key: K) -> boolean,
	Clear: (self: Collection<K, V>) -> (),
	clear: (self: Collection<K, V>) -> (),
	Size: (self: Collection<K, V>) -> number,
	size: (self: Collection<K, V>) -> number,
	Keys: (self: Collection<K, V>) -> { K },
	keys: (self: Collection<K, V>) -> { K },
	Values: (self: Collection<K, V>) -> { V },
	values: (self: Collection<K, V>) -> { V },
	Entries: (self: Collection<K, V>) -> { Entry<K, V> },
	entries: (self: Collection<K, V>) -> { Entry<K, V> },
	First: (self: Collection<K, V>) -> V?,
	first: (self: Collection<K, V>) -> V?,
	Find: (self: Collection<K, V>, predicate: (value: V, key: K) -> boolean) -> V?,
	find: (self: Collection<K, V>, predicate: (value: V, key: K) -> boolean) -> V?,
	Filter: (self: Collection<K, V>, predicate: (value: V, key: K) -> boolean) -> Collection<K, V>,
	filter: (self: Collection<K, V>, predicate: (value: V, key: K) -> boolean) -> Collection<K, V>,
	Map: (self: Collection<K, V>, callback: (value: V, key: K) -> any) -> { any },
	map: (self: Collection<K, V>, callback: (value: V, key: K) -> any) -> { any },
	ForEach: (self: Collection<K, V>, callback: (value: V, key: K) -> ()) -> (),
	forEach: (self: Collection<K, V>, callback: (value: V, key: K) -> ()) -> (),
}

type CollectionState<K, V> = {
	items: { [K]: V },
	length: number,
}

local Collection = {}
Collection.__index = Collection

local function assertKey(key: any): ()
	if key == nil then
		error("collection key must not be nil", 3)
	end
end

local function assertCallback(callback: any): ()
	if type(callback) ~= "function" then
		error("callback must be a function", 3)
	end
end

function Collection.new<K, V>(): Collection<K, V>
	local self: CollectionState<K, V> = {
		items = {},
		length = 0,
	}

	return (setmetatable(self, Collection) :: any) :: Collection<K, V>
end

function Collection:Set<K, V>(key: K, value: V): Collection<K, V>
	assertKey(key)

	local state = self :: any
	if state.items[key] == nil then
		state.length += 1
	end

	state.items[key] = value
	return self :: any
end

function Collection:Get<K, V>(key: K): V?
	assertKey(key)

	local state = self :: any
	return state.items[key]
end

function Collection:Has<K>(key: K): boolean
	assertKey(key)

	local state = self :: any
	return state.items[key] ~= nil
end

function Collection:Delete<K>(key: K): boolean
	assertKey(key)

	local state = self :: any
	if state.items[key] == nil then
		return false
	end

	state.items[key] = nil
	state.length -= 1
	return true
end

function Collection:Clear(): ()
	local state = self :: any
	state.items = {}
	state.length = 0
end

function Collection:Size(): number
	return (self :: any).length
end

function Collection:Keys<K>(): { K }
	local state = self :: any
	local keys: { K } = {}

	for key in pairs(state.items) do
		table.insert(keys, key)
	end

	return keys
end

function Collection:Values<V>(): { V }
	local state = self :: any
	local values: { V } = {}

	for _, value in pairs(state.items) do
		table.insert(values, value)
	end

	return values
end

function Collection:Entries<K, V>(): { Entry<K, V> }
	local state = self :: any
	local entries: { Entry<K, V> } = {}

	for key, value in pairs(state.items) do
		table.insert(entries, {
			Key = key,
			Value = value,
		})
	end

	return entries
end

function Collection:First<V>(): V?
	local state = self :: any

	for _, value in pairs(state.items) do
		return value
	end

	return nil
end

function Collection:Find<K, V>(predicate: (value: V, key: K) -> boolean): V?
	assertCallback(predicate)

	local state = self :: any
	for key, value in pairs(state.items) do
		if predicate(value, key) then
			return value
		end
	end

	return nil
end

function Collection:Filter<K, V>(predicate: (value: V, key: K) -> boolean): Collection<K, V>
	assertCallback(predicate)

	local state = self :: any
	local filtered = Collection.new()

	for key, value in pairs(state.items) do
		if predicate(value, key) then
			filtered:Set(key, value)
		end
	end

	return filtered :: any
end

function Collection:Map<K, V>(callback: (value: V, key: K) -> any): { any }
	assertCallback(callback)

	local state = self :: any
	local mapped: { any } = {}

	for key, value in pairs(state.items) do
		table.insert(mapped, callback(value, key))
	end

	return mapped
end

function Collection:ForEach<K, V>(callback: (value: V, key: K) -> ()): ()
	assertCallback(callback)

	local state = self :: any
	for key, value in pairs(state.items) do
		callback(value, key)
	end
end

Collection.set = Collection.Set
Collection.get = Collection.Get
Collection.has = Collection.Has
Collection.delete = Collection.Delete
Collection.clear = Collection.Clear
Collection.size = Collection.Size
Collection.keys = Collection.Keys
Collection.values = Collection.Values
Collection.entries = Collection.Entries
Collection.first = Collection.First
Collection.find = Collection.Find
Collection.filter = Collection.Filter
Collection.map = Collection.Map
Collection.forEach = Collection.ForEach

return Collection
