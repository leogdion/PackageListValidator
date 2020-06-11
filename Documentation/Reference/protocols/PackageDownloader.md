**PROTOCOL**

# `PackageDownloader`

```swift
public protocol PackageDownloader
```

## Methods
### `download(_:withSession:)`

```swift
func download<SessionType: Session>(_ packageSwiftURL: URL, withSession session: SessionType) -> Promise<URL>
```
