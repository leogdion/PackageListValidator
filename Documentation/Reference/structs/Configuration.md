**STRUCT**

# `Configuration`

```swift
public struct Configuration
```

## Properties
### `timeoutIntervalForRequest`

```swift
public let timeoutIntervalForRequest = 3000.0
```

### `timeoutIntervalForResource`

```swift
public let timeoutIntervalForResource = 6000.0
```

### `gitHubToken`

```swift
public let gitHubToken = ProcessInfo.processInfo.environment["GITHUB_API_TOKEN"]
```

### `gitHubUserName`

```swift
public let gitHubUserName = ProcessInfo.processInfo.environment["GITHUB_API_USERNAME"]
```

### `httpMaximumConnectionsPerHost`

```swift
public let httpMaximumConnectionsPerHost = 10
```

### `config`

```swift
public var config: URLSessionConfiguration
```
