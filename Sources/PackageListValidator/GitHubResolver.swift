import Foundation
import PromiseKit

struct GitHubResolver: GitHostResolver {
  let rawUrlBuilder: RawUrlBuilder = GitHubRawUrlBuilder()
  func packageUrl(for gitURL: URL) -> Promise<URL> {
    Promise { resolver in
      let repositoryName = gitURL.deletingPathExtension().lastPathComponent
      let userName = gitURL.deletingLastPathComponent().lastPathComponent
      let branchName = "master"
      resolver.fulfill(rawUrlBuilder.url(basedOn: RepoSpecification(repositoryName: repositoryName, userName: userName, branchName: branchName)))
    }
  }
}
