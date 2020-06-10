**PROTOCOL**

# `PackageFilterProtocol`

```swift
public protocol PackageFilterProtocol
```

## Methods
### `filterRepos(_:withSession:usingDecoder:_:)`

```swift
func filterRepos<SessionType: Session>(
  _ packageUrls: [URL],
  withSession session: SessionType,
  usingDecoder decoder: JSONDecoder,
  _ completed: @escaping (Result<[URL], Error>) -> Void
)
```
