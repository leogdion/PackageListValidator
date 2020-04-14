import Foundation
import PromiseKit

protocol GitHostResolver {
  func packageUrl(for gitUrl: URL) -> Promise<URL>
}

struct GitHubResolver: GitHostResolver {
  func packageUrl(for gitURL: URL) -> Promise<URL> {
    Promise { resolver in
      var rawURLComponents = ObsoleteValidator.rawURLComponentsBase
      let repositoryName = gitURL.deletingPathExtension().lastPathComponent
      let userName = gitURL.deletingLastPathComponent().lastPathComponent
      let branchName = "master"
      rawURLComponents.path = ["", userName, repositoryName, branchName, "Package.swift"].joined(separator: "/")
      guard let packageSwiftURL = rawURLComponents.url else {
        return resolver.reject(PackageError.invalidURL(gitURL))
      }
      // return .success(packageSwiftURL)
      resolver.fulfill(packageSwiftURL)
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
