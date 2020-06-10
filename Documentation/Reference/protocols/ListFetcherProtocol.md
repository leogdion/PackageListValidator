**PROTOCOL**

# `ListFetcherProtocol`

```swift
public protocol ListFetcherProtocol
```

## Methods
### `listWithSession(_:usingDecoder:_:)`

```swift
func listWithSession<SessionType: Session>(_ session: SessionType, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
```
