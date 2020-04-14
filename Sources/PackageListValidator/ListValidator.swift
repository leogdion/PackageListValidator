import Foundation

struct ValidationError: LocalizedError {
  let description: String
  let urls: [URL]

  init?(description: String, urls: [URL]) {
    guard urls.count > 1 else {
      return nil
    }

    self.description = description
    self.urls = urls
  }
}

public protocol ListValidator {
  static var key: String { get }

  static var errorDescription: String { get }

  func invalidUrls(fromUrls urls: [URL]) -> [URL]
}

extension ListValidator {
  func makeKey() -> ListValidatorKey {
    ListValidatorKey(id: Self.key, validator: self)
  }

  func validateUrls(_ urls: [URL]) -> ValidationError? {
    ValidationError(description: Self.errorDescription, urls: self.invalidUrls(fromUrls: urls))
  }
}
