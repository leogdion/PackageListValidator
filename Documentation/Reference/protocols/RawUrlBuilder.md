**PROTOCOL**

# `RawUrlBuilder`

```swift
public protocol RawUrlBuilder
```

> Builds a URL for downloading the `Package.swift` file based on the repository specifications.

## Methods
### `url(basedOn:forFileName:)`

```swift
func url(basedOn specifications: RepoSpecification, forFileName fileName: String) -> URL
```

> Builds a URL for downloading the `Package.swift`.
> - Parameter specifications: The repository specification
> - Parameter fileName: The file name to download (i.e. `Package.swift`)

#### Parameters

| Name | Description |
| ---- | ----------- |
| specifications | The repository specification |
| fileName | The file name to download (i.e. `Package.swift`) |