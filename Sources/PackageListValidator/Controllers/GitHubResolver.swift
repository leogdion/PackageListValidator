import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/**
 Based on the URL, resolves the URL to download the `Package.swift`.
 */
public struct GitHubResolver: GitHostResolver {
  public static let defaultAPIBaseURL = URL(string: "https://api.github.com/repos")!
  public static let packageFileName = "Package.swift"

  public let branchQuery: DefaultBranchQuery
  public let rawUrlBuilder: RawUrlBuilder

  public init(branchQuery: DefaultBranchQuery, rawUrlBuilder: RawUrlBuilder = GitHubRawUrlBuilder()) {
    self.branchQuery = branchQuery
    self.rawUrlBuilder = rawUrlBuilder
  }

  /**
   Returns a Promise of the downloadable URL for the `Package.swift` file.
   - Parameter gitUrl: The URL to the git repository.
   - Returns: A Promise of the URL
   */
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
