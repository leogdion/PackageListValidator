import Foundation
import PromiseKit

public struct PackageUrlFetcher: PackageUrlFetcherProtocol {
  public init() {}
  /**
   Based on repository url, find the raw url to the Package.swift file.
   - Parameter gitURL: Repository URL
   - Returns: raw git URL, if successful; other `invalidURL` if not proper git repo url or `unsupportedHost` if the host is not currently supported.
   */
  public func getPackageSwiftURL(for gitURL: URL, resolvingWith branchQuery: DefaultBranchQuery) -> Promise<URL> {
    guard let hostString = gitURL.host else {
      return Promise(error: PackageError.invalidURL(gitURL))
    }

    guard let host = GitHost(rawValue: hostString) else {
      return Promise(error: PackageError.unsupportedHost(hostString))
    }

    return host.packageUrl(for: gitURL, using: branchQuery)
  }
}
