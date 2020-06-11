**STRUCT**

# `JustBranchQuery`

```swift
public struct JustBranchQuery: DefaultBranchQuery
```

> Returns the a hard-coded branch for the repository.

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

> Returns the hard-coded branch for the repository.
>  - Parameter repo: Repository Name
> - Parameter owner: Repositry Owner
> - Parameter completed: Callback for when a result is received.

#### Parameters

| Name | Description |
| ---- | ----------- |
| repo | Repository Name |
| owner | Repositry Owner |
| completed | Callback for when a result is received. |