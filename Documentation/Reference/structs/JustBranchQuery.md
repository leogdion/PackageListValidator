**STRUCT**

# `JustBranchQuery`

```swift
public struct JustBranchQuery: DefaultBranchQuery
```

## Properties
### `branchName`

```swift
public let branchName: String
```

## Methods
### `init(branchName:)`

```swift
public init(branchName: String)
```

### `defaultBranchName(forRepoName:withOwner:_:)`

```swift
public func defaultBranchName(forRepoName _: String, withOwner _: String, _ completed: @escaping ((Result<String, Error>) -> Void))
```
