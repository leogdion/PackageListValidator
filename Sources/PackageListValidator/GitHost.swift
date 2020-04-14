import Foundation
import PromiseKit

public protocol RawUrlBuilder {
  func url (basedOn specifications: RepoSpecification) -> URL
}

public struct RepoSpecification {
  let repositoryName : String
  let userName : String
  let branchName : String
}

public struct GitHubRawUrlBuilder : RawUrlBuilder{
  let rawURLComponentsBase: URLComponents = URLComponents(string: "https://raw.githubusercontent.com")!
  public func url (basedOn specifications: RepoSpecification) -> URL {

    var rawURLComponents = rawURLComponentsBase
    rawURLComponents.path = ["", specifications.userName, specifications.repositoryName, specifications.branchName, "Package.swift"].joined(separator: "/")
    guard let url = rawURLComponents.url else {
      preconditionFailure("Invalid URL string: \(rawURLComponents.description)")
    }
    return url
  }
}
protocol GitHostResolver {
  func packageUrl(for gitUrl: URL) -> Promise<URL>
}

struct GitHubResolver: GitHostResolver {
  let rawUrlBuilder : RawUrlBuilder = GitHubRawUrlBuilder()
  func packageUrl(for gitURL: URL) -> Promise<URL> {
    Promise { resolver in
      let repositoryName = gitURL.deletingPathExtension().lastPathComponent
      let userName = gitURL.deletingLastPathComponent().lastPathComponent
      let branchName = "master"

      
      // return .success(packageSwiftURL)
      resolver.fulfill(rawUrlBuilder.url(basedOn: RepoSpecification(repositoryName: repositoryName, userName: userName, branchName: branchName)))
    }
  }
}

/**
 List of git hosts for which we can pull single files
 */
enum GitHost: String {
  static let resolvers: [GitHost: GitHostResolver] = [.github: GitHubResolver()]
  case github = "github.com"
}

extension GitHost {
  func packageUrl(for gitUrl: URL) -> Promise<URL> {
    Self.resolvers[self]!.packageUrl(for: gitUrl)
  }
}
