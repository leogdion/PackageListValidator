import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct GitHubResolver: GitHostResolver {
  public static let defaultAPIBaseURL = URL(string: "https://api.github.com/repos")!
  public init(branchQuery: DefaultBranchQuery) {
    self.branchQuery = branchQuery
  }

  let branchQuery: DefaultBranchQuery
  let rawUrlBuilder: RawUrlBuilder = GitHubRawUrlBuilder()
  func packageUrl(for gitURL: URL) -> Promise<URL> {
    Promise { resolver in
      let repositoryName = gitURL.deletingPathExtension().lastPathComponent
      let userName = gitURL.deletingLastPathComponent().lastPathComponent
      branchQuery.defaultBranchName(forRepoName: repositoryName, withOwner: userName) { branchNameResult in
        let result = branchNameResult.map { branchName in
          RepoSpecification(repositoryName: repositoryName, userName: userName, branchName: branchName)
        }.map { repoSpecs in
          self.rawUrlBuilder.url(basedOn: repoSpecs, forFileName: "Package.swift")
        }
        resolver.resolve(result)
      }
    }
  }
}
