**STRUCT**

# `ListFetcher`

```swift
public struct ListFetcher: ListFetcherProtocol
```

## Methods
### `listWithSession(_:usingDecoder:_:)`

```swift
public func listWithSession(_ session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
```
