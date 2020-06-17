**PROTOCOL**

# `DefaultBranchQuery`

```swift
public protocol DefaultBranchQuery
```

Returns the default branch for the repository.

## Methods
### `defaultBranchName(forRepoName:withOwner:_:)`

```swift
func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void))
```

Returns the default branch for the repository.
 - Parameter repo: Repository Name
- Parameter owner: Repositry Owner
- Parameter completed: Callback for when a result is received.

#### Parameters

| Name | Description |
| ---- | ----------- |
| repo | Repository Name |
| owner | Repositry Owner |
| completed | Callback for when a result is received. |