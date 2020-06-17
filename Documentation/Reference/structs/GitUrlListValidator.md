**STRUCT**

# `GitUrlListValidator`

```swift
public struct GitUrlListValidator: ListValidator
```

Verifies that each URL is a valid git repository.

## Methods
### `init()`

```swift
public init()
```

### `invalidUrls(fromUrls:)`

```swift
public func invalidUrls(fromUrls urls: [URL]) -> [URL]
```

Verifies that all URLs are valid git repositories.
- Parameter urls: The urls to verify.
- Returns: The urls which are invalid.

#### Parameters

| Name | Description |
| ---- | ----------- |
| urls | The urls to verify. |