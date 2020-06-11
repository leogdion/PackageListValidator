import Foundation

/**
 Builds a URL for downloading the `Package.swift` file based on the repository specifications.
 */
public struct GitHubRawUrlBuilder: RawUrlBuilder {
  public init(rawURLComponentsBase: URLComponents = Self.defaultURLComponents) {
    self.rawURLComponentsBase = rawURLComponentsBase
  }

  /**
   Default Base URL Components.
   */
  public static let defaultURLComponents = URLComponents(string: "https://raw.githubusercontent.com")!

  /**
   Base URL Components.
   */
  public let rawURLComponentsBase: URLComponents

  /**
   Builds a URL for downloading the `Package.swift`.
   - Parameter specifications: The repository specification
   - Parameter fileName: The file name to download (i.e. `Package.swift`)
   */
  public func url(basedOn specifications: RepoSpecification, forFileName fileName: String) -> URL {
    var rawURLComponents = rawURLComponentsBase
    rawURLComponents.path = [
      "", specifications.userName, specifications.repositoryName, specifications.branchName, fileName
    ].joined(separator: "/")
    guard let url = rawURLComponents.url else {
      preconditionFailure("Invalid URL string: \(rawURLComponents.description)")
    }
    return url
  }
}
