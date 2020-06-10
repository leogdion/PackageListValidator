**STRUCT**

# `GitHubDefaultBranchQuery`

```swift
public struct GitHubDefaultBranchQuery<SessionType: Session>: DefaultBranchQuery
```

## Properties
### `apiBaseURL`

```swift
public let apiBaseURL: URL
```

### `decoder`

```swift
public let decoder: JSONDecoder
```

### `session`

```swift
public let session: SessionType
```

### `gitHubToken`

```swift
public let gitHubToken: String?
```

### `gitHubUserName`

```swift
public let gitHubUserName: String?
```

## Methods
### `init(session:decoder:baseURL:gitHubUserName:gitHubToken:)`

```swift
public init(session: SessionType, decoder: JSONDecoder, baseURL: URL? = nil, gitHubUserName: String? = nil, gitHubToken _: String? = nil)
```

### `defaultBranchName(forRepoName:withOwner:_:)`

```swift
public func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void))
```
