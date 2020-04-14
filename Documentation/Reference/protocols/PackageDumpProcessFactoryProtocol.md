**PROTOCOL**

# `PackageDumpProcessFactoryProtocol`

```swift
public protocol PackageDumpProcessFactoryProtocol
```

## Methods
### `dumpPackageProcessAt(_:outputTo:errorsTo:)`

```swift
func dumpPackageProcessAt(_ packageDirectoryURL: URL, outputTo pipe: Pipe, errorsTo errorPipe: Pipe) -> Process
```

> Creates a `Process` for dump the package metadata.
> - Parameter packageDirectoryURL: File URL to Package
> - Parameter outputTo: standard output pipe
> - Parameter errorsTo: error pipe

#### Parameters

| Name | Description |
| ---- | ----------- |
| packageDirectoryURL | File URL to Package |
| outputTo | standard output pipe |
| errorsTo | error pipe |