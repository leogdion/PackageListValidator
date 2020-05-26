**PROTOCOL**

# `PackageFilterProtocol`

```swift
public protocol PackageFilterProtocol
```

## Methods
### `filterRepos(_:withSession:usingDecoder:_:)`

```swift
func filterRepos(
  _ packageUrls: [URL],
  withSession session: URLSession,
  usingDecoder decoder: JSONDecoder,
  _ completed: @escaping (Result<[URL], Error>) -> Void
)
```
