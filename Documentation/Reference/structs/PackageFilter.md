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
### `init(type:)`

```swift
public init(type: PackageFilterType)
```

### `filterRepos(_:withSession:usingDecoder:_:)`

```swift
public func filterRepos<SessionType: Session>(
  _ packageUrls: [URL],
  withSession session: SessionType,
  usingDecoder decoder: JSONDecoder,
  _ completed: @escaping (Result<[URL], Error>) -> Void
)
```
