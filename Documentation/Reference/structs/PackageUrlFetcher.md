**STRUCT**

# `PackageUrlFetcher`

```swift
public struct PackageUrlFetcher: PackageUrlFetcherProtocol
```

## Methods
### `getPackageSwiftURL(for:)`

```swift
public func getPackageSwiftURL(for gitURL: URL) -> Promise<URL>
```

> Based on repository url, find the raw url to the Package.swift file.
> - Parameter gitURL: Repository URL
> - Returns: raw git URL, if successful; other `invalidURL` if not proper git repo url or `unsupportedHost` if the host is not currently supported.

#### Parameters

| Name | Description |
| ---- | ----------- |
| gitURL | Repository URL |