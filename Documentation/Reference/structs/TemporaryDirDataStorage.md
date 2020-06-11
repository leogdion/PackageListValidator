**STRUCT**

# `TemporaryDirDataStorage`

```swift
public struct TemporaryDirDataStorage: TemporaryDataStorage
```

## Properties
### `temporaryDirectoryURL`

```swift
public let temporaryDirectoryURL: () -> (URL)
```

## Methods
### `init(temporaryDirectoryURL:)`

```swift
public init(temporaryDirectoryURL: (() -> (URL))? = nil)
```

### `directoryUrl(forSavingData:)`

```swift
public func directoryUrl(forSavingData data: Data) throws -> URL
```
