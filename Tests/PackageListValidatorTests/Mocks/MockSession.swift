import Foundation
import PackageListValidator

struct MockSession<Success: Encodable>: Session {
  let result: Result<Success, Error>?
  let onURL: ((URL) -> Void)?
  func request(withURL url: URL) -> MockRequest {
    onURL?(url)
    return MockRequest(url: url)
  }

  func begin(request _: MockRequest, _ completionHandler: @escaping (Data?, MockResponse?, Error?) -> Void) -> Task {
    guard let result = self.result else {
      completionHandler(nil, nil, nil)
      return MockTask()
    }
    let data: Data?
    let error: Error?
    let encoder = JSONEncoder()
    let dataResult = result.flatMap { success in
      Result {
        try encoder.encode(success)
      }
    }
    do {
      data = try dataResult.get()
      error = nil
    } catch let caughtError {
      error = caughtError
      data = nil
    }
    completionHandler(data, nil, error)
    return MockTask()
  }
}
