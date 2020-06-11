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

### `invalidURL(_:)`

```swift
case invalidURL(URL)
```

### `unsupportedHost(_:)`

```swift
case unsupportedHost(String)
```

### `readError(_:)`

```swift
case readError(Error?)
```

### `badDump(_:)`

```swift
case badDump(String?)
```

### `decodingError(_:)`

```swift
case decodingError(Error)
```

### `missingProducts`

```swift
case missingProducts
```

### `dumpTimeout`

```swift
case dumpTimeout
```

## Properties
### `friendlyName`

```swift
public var friendlyName: String
```
