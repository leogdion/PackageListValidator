import Foundation
import PromiseKit

/**
 List of git hosts for which we can pull single files
 */
enum GitHost: String {
  static let resolvers: [GitHost: (DefaultBranchQuery) -> GitHostResolver] = [.github: { GitHubResolver(branchQuery: $0) }]
  case github = "github.com"
}

extension GitHost {
  func packageUrl(for gitUrl: URL, using branchQuery: DefaultBranchQuery) -> Promise<URL> {
    Self.resolvers[self]!(branchQuery).packageUrl(for: gitUrl)
  }
}
