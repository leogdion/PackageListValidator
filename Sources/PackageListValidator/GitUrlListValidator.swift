import Foundation

public struct GitUrlListValidator: ListValidator {
  public static var errorDescription = "Missing .git extension"

  public func invalidUrls(fromUrls urls: [URL]) -> [URL] {
    urls.filter { $0.pathExtension != "git" }
  }

  public static let key = "url"
}
