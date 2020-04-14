**STRUCT**

# `PackageFilter`

```swift
public struct PackageFilter: PackageFilterProtocol
```

## Properties
### `type`

```swift
public let type: PackageFilterType
```

## Methods
### `filterRepos(_:withSession:usingDecoder:_:)`

```swift
public func filterRepos(
  _ packageUrls: [URL],
  withSession session: URLSession,
  usingDecoder decoder: JSONDecoder,
  _ completed: @escaping (Result<[URL], Error>) -> Void
)
```
