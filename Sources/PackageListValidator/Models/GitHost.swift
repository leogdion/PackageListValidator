import Foundation
import PromiseKit

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
