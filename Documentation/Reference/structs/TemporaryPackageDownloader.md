**STRUCT**

# `TemporaryPackageDownloader`

```swift
public struct TemporaryPackageDownloader: PackageDownloader
```

## Methods
### `download(_:withSession:)`

```swift
public func download<SessionType: Session>(_ packageSwiftURL: URL, withSession session: SessionType) -> Promise<URL>
```
