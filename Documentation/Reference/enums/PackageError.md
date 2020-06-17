**ENUM**

# `PackageError`

```swift
public enum PackageError: Error
```

List of possible errors for each package

## Cases
### `noResult`

```swift
case noResult
```

No Result Returned From Any Call

### `invalidURL(_:)`

```swift
case invalidURL(URL)
```

The URL listed is invalid for a repository.

### `unsupportedHost(_:)`

```swift
case unsupportedHost(String)
```

The git host is not supported.

### `badDump(_:)`

```swift
case badDump(String?)
```

SPM cannot decipher the `Package.swift` file.

### `decodingError(_:)`

```swift
case decodingError(Error)
```

Could not decode the result the pacakge dump.

### `missingProducts`

```swift
case missingProducts
```

No product listed.

### `dumpTimeout`

```swift
case dumpTimeout
```

The `dump-package` process timed out.

## Properties
### `friendlyName`

```swift
public var friendlyName: String
```
