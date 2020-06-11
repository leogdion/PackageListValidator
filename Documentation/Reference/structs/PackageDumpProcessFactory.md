**STRUCT**

# `PackageDumpProcessFactory`

```swift
public struct PackageDumpProcessFactory: PackageDumpProcessFactoryProtocol
```

## Methods
### `init()`

```swift
public init()
```

### `dumpPackageProcessAt(_:outputTo:errorsTo:)`

```swift
public func dumpPackageProcessAt(_ packageDirectoryURL: URL, outputTo pipe: Pipe, errorsTo errorPipe: Pipe) -> Process
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| packageDirectoryURL | File URL to Package |
| outputTo | standard output pipe |
| errorsTo | error pipe |