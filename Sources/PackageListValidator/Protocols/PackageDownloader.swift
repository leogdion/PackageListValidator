import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol PackageDownloader {
  func download<SessionType: Session>(_ packageSwiftURL: URL, withSession session: SessionType) -> Promise<URL>
}
