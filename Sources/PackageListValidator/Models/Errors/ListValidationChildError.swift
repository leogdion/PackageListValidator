import Foundation

public struct ListValidationChildError: LocalizedError {
  public let description: String
  public let urls: [URL]

  public init?(description: String, urls: [URL]) {
    guard urls.count >= 1 else {
      return nil
    }

    self.description = description
    self.urls = urls
  }
}
