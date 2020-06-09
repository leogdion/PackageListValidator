**PROTOCOL**

# `DefaultBranchQuery`

```swift
public protocol DefaultBranchQuery
```

## Methods
### `defaultBranchName(forRepoName:withOwner:_:)`

```swift
func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void))
```
