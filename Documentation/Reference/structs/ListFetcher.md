**STRUCT**

# `ListFetcher`

```swift
public struct ListFetcher: ListFetcherProtocol
```

## Methods
### `listWithSession(_:usingDecoder:_:)`

```swift
public func listWithSession<SessionType: Session>(_ session: SessionType, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
```
