import Foundation
import PromiseKit

public protocol PackageUrlFetcherProtocol {
  func getPackageSwiftURL(for gitURL: URL) -> Promise<URL>
}
public struct PackageUrlFetcher : PackageUrlFetcherProtocol {
  public func getPackageSwiftURL(for gitURL: URL) -> Promise<URL> {
    //return Promise{
      //(resolver) in
      guard let hostString = gitURL.host else {
        return Promise(error: PackageError.invalidURL(gitURL))
      }

      guard let host = GitHost(rawValue: hostString) else {
        //return .failure(PackageError.unsupportedHost(hostString))
        return Promise(error: PackageError.unsupportedHost(hostString))
      }
      
      return host.packageUrl(for: gitURL)

    
  }
}
