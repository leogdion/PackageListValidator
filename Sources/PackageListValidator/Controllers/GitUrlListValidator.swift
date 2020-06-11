import Foundation

public struct GitUrlListValidator: ListValidator {
  public static let errorDescription = "Missing .git extension"
  public static let successDescription = "All Urls Valid."
  public init() {}
  #warning("Should All Urls use the same protocol/scheme?")
  public func invalidUrls(fromUrls urls: [URL]) -> [URL] {
    urls.filter { $0.pathExtension != "git" }
  }

  public static let key = "url"
}
