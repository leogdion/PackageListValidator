import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol PackageDownloader {
  func download(_ packageSwiftURL: URL, withSession session: URLSession) -> Promise<URL>
}
