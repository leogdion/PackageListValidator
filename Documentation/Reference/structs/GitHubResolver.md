**STRUCT**

# `GitHubResolver`

```swift
public struct GitHubResolver: GitHostResolver
```

> Based on the URL, resolves the URL to download the `Package.swift`.

## Properties
### `branchQuery`

```swift
public let branchQuery: DefaultBranchQuery
```

### `rawUrlBuilder`

```swift
public let rawUrlBuilder: RawUrlBuilder
```

## Methods
### `init(branchQuery:rawUrlBuilder:)`

```swift
public init(branchQuery: DefaultBranchQuery, rawUrlBuilder: RawUrlBuilder = GitHubRawUrlBuilder())
```

### `packageUrl(for:)`

```swift
public func packageUrl(for gitURL: URL) -> Promise<URL>
```

> Returns a Promise of the downloadable URL for the `Package.swift` file.
> - Parameter gitUrl: The URL to the git repository.
> - Returns: A Promise of the URL

#### Parameters

| Name | Description |
| ---- | ----------- |
| gitUrl | The URL to the git repository. |