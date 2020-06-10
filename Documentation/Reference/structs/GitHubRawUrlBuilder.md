**STRUCT**

# `GitHubRawUrlBuilder`

```swift
public struct GitHubRawUrlBuilder: RawUrlBuilder
```

## Properties
### `rawURLComponentsBase`

```swift
public let rawURLComponentsBase: URLComponents
```

## Methods
### `init(rawURLComponentsBase:)`

```swift
public init(rawURLComponentsBase: URLComponents = Self.defaultURLComponents)
```

### `url(basedOn:forFileName:)`

```swift
public func url(basedOn specifications: RepoSpecification, forFileName fileName: String) -> URL
```
