import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol Session {
  associatedtype RequestType: SessionRequest
  associatedtype ResponseType: Response
  func request(withURL url: URL) -> RequestType
  @discardableResult
  func begin(request: RequestType, _ completionHandler: @escaping (Data?, ResponseType?, Error?) -> Void) -> Task
}

extension URLSession: Session {
  public typealias RequestType = URLRequest
  public typealias ResponseType = URLResponse
  public func request(withURL url: URL) -> URLRequest {
    URLRequest(url: url)
  }

  public func begin(request: URLRequest, _ completionHandler: @escaping (Data?, ResponseType?, Error?) -> Void) -> Task {
    let task = dataTask(with: request, completionHandler: completionHandler)
    task.resume()
    return task
  }
}
