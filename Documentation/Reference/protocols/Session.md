**PROTOCOL**

# `Session`

```swift
public protocol Session
```

## Methods
### `request(withURL:)`

```swift
func request(withURL url: URL) -> RequestType
```

### `begin(request:_:)`

```swift
func begin(request: RequestType, _ completionHandler: @escaping (Data?, ResponseType?, Error?) -> Void) -> Task
```
