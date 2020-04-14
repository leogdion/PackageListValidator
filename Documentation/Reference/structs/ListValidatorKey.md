**STRUCT**

# `ListValidatorKey`

```swift
public struct ListValidatorKey: Identifiable, Hashable
```

## Properties
### `id`

```swift
public let id: String
```

### `validator`

```swift
public let validator: ListValidator
```

## Methods
### `==(_:_:)`

```swift
public static func == (lhs: ListValidatorKey, rhs: ListValidatorKey) -> Bool
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| lhs | A value to compare. |
| rhs | Another value to compare. |

### `hash(into:)`

```swift
public func hash(into hasher: inout Hasher)
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| hasher | The hasher to use when combining the components of this instance. |