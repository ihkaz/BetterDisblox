# Collection API

## Constructor

```lua
local collection = BetterDisblox.Collection.new()
```

## Methods

| Method | Description |
| --- | --- |
| `set(key, value)` | Store a value. |
| `get(key)` | Return a value or `nil`. |
| `has(key)` | Return whether a key exists. |
| `delete(key)` | Delete a key and return whether it existed. |
| `clear()` | Remove all entries. |
| `size()` | Return entry count. |
| `keys()` | Return all keys. |
| `values()` | Return all values. |
| `entries()` | Return `{ Key, Value }` entries. |
| `first()` | Return the first stored value. |
| `find(predicate)` | Return the first value matching a predicate. |
| `filter(predicate)` | Return a new filtered collection. |
| `map(callback)` | Return mapped values. |
| `forEach(callback)` | Run a callback for each entry. |

PascalCase aliases are available for all methods.
