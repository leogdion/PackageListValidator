import Foundation

/**
 Verifies that each URL is a valid git repository.
 */
public struct GitUrlListValidator: ListValidator {
  public static let errorDescription = "Missing .git extension"
  public static let successDescription = "All Urls Valid."
  public init() {}
  #warning("Should All Urls use the same protocol/scheme?")
  /**
   Verifies that all URLs are valid git repositories.
   - Parameter urls: The urls to verify.
   - Returns: The urls which are invalid.
   */
  public func invalidUrls(fromUrls urls: [URL]) -> [URL] {
    urls.filter { $0.pathExtension != "git" }
  }

  public static let key = "url"
}
