**STRUCT**

# `TemporaryPackageDownloader`

```swift
public struct TemporaryPackageDownloader: PackageDownloader
```

## Methods
### `init(branchQuery:urlFetcher:tempDataStorage:delay:)`

```swift
public init(branchQuery: DefaultBranchQuery,
            urlFetcher: PackageUrlFetcherProtocol = PackageUrlFetcher(),
            tempDataStorage: TemporaryDataStorage = TemporaryDirDataStorage(), delay: TimeInterval = 10.0)
```

### `download(_:withSession:)`

```swift
public func download<SessionType: Session>(_ packageSwiftURL: URL, withSession session: SessionType) -> Promise<URL>
```
