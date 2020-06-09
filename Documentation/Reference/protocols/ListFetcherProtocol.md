**PROTOCOL**

# `ListFetcherProtocol`

```swift
public protocol ListFetcherProtocol
```

## Methods
### `listWithSession(_:usingDecoder:_:)`

```swift
func listWithSession(_ session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
```
