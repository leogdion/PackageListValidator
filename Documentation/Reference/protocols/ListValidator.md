**PROTOCOL**

# `ListValidator`

```swift
public protocol ListValidator
```

> Verifies that the list of the URLs as valid.

## Methods
### `invalidUrls(fromUrls:)`

```swift
func invalidUrls(fromUrls urls: [URL]) -> [URL]
```

> Verifies that the list is invalid.
> - Parameter urls: The urls to verify.
> - Returns: The urls which are invalid.

#### Parameters

| Name | Description |
| ---- | ----------- |
| urls | The urls to verify. |