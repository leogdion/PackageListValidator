**EXTENSION**

# `URLSession`
```swift
extension URLSession: Session
```

## Methods
### `request(withURL:)`

```swift
public func request(withURL url: URL) -> URLRequest
```

### `begin(request:_:)`

```swift
public func begin(request: URLRequest, _ completionHandler: @escaping (Data?, ResponseType?, Error?) -> Void) -> Task
```
