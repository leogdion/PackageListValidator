**STRUCT**

# `PackageFilter`

```swift
public struct PackageFilter: PackageFilterProtocol
```

Filters the urls in an array based another list (i.e. master list).

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

Filters the urls in an array based another list (i.e. master list).
- Parameter packageUrls: The list to filter.
- Parameter session: The session to read the other list from.
- Parameter decoder: The JSONDecoder
- Parameter completed: The callback made when the result is received.

#### Parameters

| Name | Description |
| ---- | ----------- |
| packageUrls | The list to filter. |
| session | The session to read the other list from. |
| decoder | The JSONDecoder |
| completed | The callback made when the result is received. |