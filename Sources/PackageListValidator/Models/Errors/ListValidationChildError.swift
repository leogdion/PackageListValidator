import Foundation

struct ListValidationChildError: LocalizedError {
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
