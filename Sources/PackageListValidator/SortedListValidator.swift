import Foundation

public struct SortedListValidator: ListValidator {
  public static let errorDescription = "Urls not sorted."
  public static let successDescription = "All urls are sorted."

  public func invalidUrls(fromUrls urls: [URL]) -> [URL] {
    let sortedUrls = urls.sorted {
      $0.absoluteString.lowercased() < $1.absoluteString.lowercased()
    }

    return zip(urls, sortedUrls).enumerated().filter { $0.element.0 != $0.element.1 }.map {
      $0.element.0
    }
  }

  public static let key = "sorted"
}
