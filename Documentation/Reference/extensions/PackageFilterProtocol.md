**EXTENSION**

# `PackageFilterProtocol`
```swift
public extension PackageFilterProtocol
```

## Methods
### `filterRepos(_:withSession:usingDecoder:)`

```swift
func filterRepos<SessionType: Session>(_ packageUrls: [URL], withSession session: SessionType, usingDecoder decoder: JSONDecoder) -> Promise<[URL]>
```
