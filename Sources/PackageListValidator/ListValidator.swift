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
  static var errorDescription: String { get }
  static var successDescription: String { get }

  func invalidUrls(fromUrls urls: [URL]) -> [URL]
}

extension ListValidator {
  func validateUrls(_ urls: [URL]) -> ValidationError? {
    ValidationError(description: Self.errorDescription, urls: invalidUrls(fromUrls: urls))
  }
}
