import Foundation

public protocol ListValidator {
  static var errorDescription: String { get }
  static var successDescription: String { get }

  func invalidUrls(fromUrls urls: [URL]) -> [URL]
}

extension ListValidator {
  func validateUrls(_ urls: [URL]) -> ListValidationChildError? {
    ListValidationChildError(description: Self.errorDescription, urls: invalidUrls(fromUrls: urls))
  }
}
