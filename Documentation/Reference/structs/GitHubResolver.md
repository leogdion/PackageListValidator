**STRUCT**

# `GitHubResolver`

```swift
public struct GitHubResolver: GitHostResolver
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
