**PROTOCOL**

# `PackageListJsonURLParserProtocol`

```swift
public protocol PackageListJsonURLParserProtocol
```

## Methods
### `url(packagesFromDirectories:andPath:)`

```swift
func url(packagesFromDirectories directoryURLs: [URL], andPath path: String?) -> URL?
```

> Based on the directories passed and command line arguments, find the `packages.json` url.
> - Parameter directoryURLs: directory url to search for `packages.json` file
> - Parameter arguments: Command Line arguments which may contain a path to a `packages.json` file.

#### Parameters

| Name | Description |
| ---- | ----------- |
| directoryURLs | directory url to search for `packages.json` file |
| arguments | Command Line arguments which may contain a path to a `packages.json` file. |