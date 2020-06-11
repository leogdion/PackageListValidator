**STRUCT**

# `GitHubRawUrlBuilder`

```swift
public struct GitHubRawUrlBuilder: RawUrlBuilder
```

> Builds a URL for downloading the `Package.swift` file based on the repository specifications.

## Properties
### `rawURLComponentsBase`

```swift
public let rawURLComponentsBase: URLComponents
```

> Base URL Components.

## Methods
### `init(rawURLComponentsBase:)`

```swift
public init(rawURLComponentsBase: URLComponents = Self.defaultURLComponents)
```

### `url(basedOn:forFileName:)`

```swift
public func url(basedOn specifications: RepoSpecification, forFileName fileName: String) -> URL
```

> Builds a URL for downloading the `Package.swift`.
> - Parameter specifications: The repository specification
> - Parameter fileName: The file name to download (i.e. `Package.swift`)

#### Parameters

| Name | Description |
| ---- | ----------- |
| specifications | The repository specification |
| fileName | The file name to download (i.e. `Package.swift`) |