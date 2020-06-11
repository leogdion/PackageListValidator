import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol PackageFilterProtocol {
  func filterRepos<SessionType: Session>(
    _ packageUrls: [URL],
    withSession session: SessionType,
    usingDecoder decoder: JSONDecoder,
    _ completed: @escaping (Result<[URL], Error>) -> Void
  )
}

public extension PackageFilterProtocol {
  func filterRepos<SessionType: Session>(
    _ packageUrls: [URL],
    withSession session: SessionType,
    usingDecoder decoder: JSONDecoder
  ) -> Promise<[URL]> {
    Promise<[URL]> { resolver in
      self.filterRepos(packageUrls, withSession: session, usingDecoder: decoder) {
        resolver.resolve($0)
      }
    }
  }
}
