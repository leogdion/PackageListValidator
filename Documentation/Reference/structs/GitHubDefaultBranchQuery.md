**STRUCT**

# `GitHubDefaultBranchQuery`

```swift
public struct GitHubDefaultBranchQuery<SessionType: Session>: DefaultBranchQuery
```

Returns the default branch for the repository by calling the GitHub API.

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

Returns the default branch for the repository from the GitHub API.
 - Parameter repo: Repository Name
- Parameter owner: Repositry Owner
- Parameter completed: Callback for when a result is received.

#### Parameters

| Name | Description |
| ---- | ----------- |
| repo | Repository Name |
| owner | Repositry Owner |
| completed | Callback for when a result is received. |