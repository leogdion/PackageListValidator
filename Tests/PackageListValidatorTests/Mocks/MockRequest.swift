import Foundation
import PackageListValidator

struct MockRequest: SessionRequest {
  let url: URL
  var body: Data?
  var headers = [String: String]()
  var method: String?

  mutating func addHeader(withValue value: String, forField field: String) {
    headers[field] = value
  }
}
