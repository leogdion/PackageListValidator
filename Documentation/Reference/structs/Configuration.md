**STRUCT**

# `Configuration`

```swift
public struct Configuration
```

## Properties
### `semaphoreCount`

```swift
public let semaphoreCount = 3
```

### `timeoutIntervalForRequest`

```swift
public let timeoutIntervalForRequest = 3000.0
```

### `timeoutIntervalForResource`

```swift
public let timeoutIntervalForResource = 6000.0
```

### `rawURLComponentsBase`

```swift
public let rawURLComponentsBase = URLComponents(string: "https://raw.githubusercontent.com")!
```

### `masterPackageGitHubPath`

```swift
public let masterPackageGitHubPath = "daveverwer/SwiftPMLibrary/master/packages.json"
```

### `masterPackageList`

```swift
public var masterPackageList: URL?
```

### `logEveryCount`

```swift
public let logEveryCount = 10
```

### `httpMaximumConnectionsPerHost`

```swift
public let httpMaximumConnectionsPerHost = 10
```

### `displayProgress`

```swift
public let displayProgress = false
```

### `processTimeout`

```swift
public let processTimeout = 50.0
```

### `config`

```swift
public var config: URLSessionConfiguration
```
