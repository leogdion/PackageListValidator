import Foundation

/**
 Verifies that the list of the URLs as valid.
 */
public protocol ListValidator {
  static var errorDescription: String { get }
  static var successDescription: String { get }

  /**
   Verifies that the list is invalid.
   - Parameter urls: The urls to verify.
   - Returns: The urls which are invalid.
   */
  func invalidUrls(fromUrls urls: [URL]) -> [URL]
}

public extension ListValidator {
  func validateUrls(_ urls: [URL]) -> ListValidationChildError? {
    ListValidationChildError(description: Self.errorDescription, urls: invalidUrls(fromUrls: urls))
  }
}
