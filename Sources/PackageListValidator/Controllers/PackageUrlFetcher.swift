import Foundation
import PromiseKit

public struct PackageUrlFetcher: PackageUrlFetcherProtocol {
  /**
   Based on repository url, find the raw url to the Package.swift file.
   - Parameter gitURL: Repository URL
   - Returns: raw git URL, if successful; other `invalidURL` if not proper git repo url or `unsupportedHost` if the host is not currently supported.
   */
  public func getPackageSwiftURL(for gitURL: URL) -> Promise<URL> {
    // return Promise{
    // (resolver) in
    guard let hostString = gitURL.host else {
      return Promise(error: PackageError.invalidURL(gitURL))
    }

    guard let host = GitHost(rawValue: hostString) else {
      // return .failure(PackageError.unsupportedHost(hostString))
      return Promise(error: PackageError.unsupportedHost(hostString))
    }

    return host.packageUrl(for: gitURL)
  }
}
