import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol SessionRequest {
  var body: Data? { get set }
  var method: String? { get set }
  mutating func addHeader(withValue value: String, forField field: String)
}

extension URLRequest: SessionRequest {
  public mutating func addHeader(withValue value: String, forField field: String) {
    addValue(value, forHTTPHeaderField: field)
  }

  public var body: Data? {
    get {
      httpBody
    }
    set {
      httpBody = newValue
    }
  }

  public var method: String? {
    get {
      httpMethod
    }
    set {
      httpMethod = newValue
    }
  }
}
