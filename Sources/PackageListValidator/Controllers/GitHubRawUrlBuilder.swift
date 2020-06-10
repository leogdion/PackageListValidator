import Foundation

public struct GitHubRawUrlBuilder: RawUrlBuilder {
  public init(rawURLComponentsBase: URLComponents = Self.defaultURLComponents) {
    self.rawURLComponentsBase = rawURLComponentsBase
  }

  public static let defaultURLComponents = URLComponents(string: "https://raw.githubusercontent.com")!
  public let rawURLComponentsBase: URLComponents
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
