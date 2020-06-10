import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol Response {
  var httpStatusCode: Int? { get }
}

extension URLResponse: Response {
  public var httpStatusCode: Int? {
    (self as? HTTPURLResponse)?.statusCode
  }
}
