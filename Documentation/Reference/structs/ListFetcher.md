**STRUCT**

# `ListFetcher`

```swift
public struct ListFetcher: ListFetcherProtocol
```

## Properties
### `listURL`

```swift
public let listURL: URL
```

## Methods
### `init(listURL:)`

```swift
public init(listURL: URL)
```

### `listWithSession(_:usingDecoder:_:)`

```swift
public func listWithSession<SessionType: Session>(
  _ session: SessionType,
  usingDecoder decoder: JSONDecoder,
  _ completed: @escaping (Result<[URL], Error>) -> Void
)
```
