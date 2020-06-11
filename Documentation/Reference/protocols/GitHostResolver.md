**PROTOCOL**

# `GitHostResolver`

```swift
public protocol GitHostResolver
```

> Based on the URL, resolves the URL to download the `Package.swift`.

## Methods
### `packageUrl(for:)`

```swift
func packageUrl(for gitUrl: URL) -> Promise<URL>
```

> Returns a Promise of the downloadable URL for the `Package.swift` file.
> - Parameter gitUrl: The URL to the git repository.
> - Returns: A Promise of the URL

#### Parameters

| Name | Description |
| ---- | ----------- |
| gitUrl | The URL to the git repository. |