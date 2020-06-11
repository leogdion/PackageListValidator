import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct GitHubResolver: GitHostResolver {
  public static let defaultAPIBaseURL = URL(string: "https://api.github.com/repos")!
  public static let packageFileName = "Package.swift"
  public init(branchQuery: DefaultBranchQuery, rawUrlBuilder: RawUrlBuilder = GitHubRawUrlBuilder()) {
    self.branchQuery = branchQuery
    self.rawUrlBuilder = rawUrlBuilder
  }

  let branchQuery: DefaultBranchQuery
  let rawUrlBuilder: RawUrlBuilder
  public func packageUrl(for gitURL: URL) -> Promise<URL> {
    Promise { resolver in
      let repositoryName = gitURL.deletingPathExtension().lastPathComponent
      let userName = gitURL.deletingLastPathComponent().lastPathComponent
      branchQuery.defaultBranchName(forRepoName: repositoryName, withOwner: userName) { branchNameResult in
        let result = branchNameResult.map { branchName in
          RepoSpecification(repositoryName: repositoryName, userName: userName, branchName: branchName)
        }.map { repoSpecs in
          self.rawUrlBuilder.url(basedOn: repoSpecs, forFileName: Self.packageFileName)
        }
        resolver.resolve(result)
      }
    }
  }
}
