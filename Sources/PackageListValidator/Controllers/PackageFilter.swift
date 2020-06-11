import Foundation
import PromiseKit

/**
 Filters the urls in an array based another list (i.e. master list).
 */
public struct PackageFilter: PackageFilterProtocol {
  public let type: PackageFilterType

  public init(type: PackageFilterType) {
    self.type = type
  }

  /**
   Filters the urls in an array based another list (i.e. master list).
   - Parameter packageUrls: The list to filter.
   - Parameter session: The session to read the other list from.
   - Parameter decoder: The JSONDecoder
   - Parameter completed: The callback made when the result is received.
   */
  public func filterRepos<SessionType: Session>(
    _ packageUrls: [URL],
    withSession session: SessionType,
    usingDecoder decoder: JSONDecoder,
    _ completed: @escaping (Result<[URL], Error>) -> Void
  ) {
    guard case let .diffWith(fetcher) = type else {
      completed(.success(packageUrls))
      return
    }
    fetcher.listWithSession(session, usingDecoder: decoder) { result in
      guard case let .success(masterList) = result else {
        completed(result)
        return
      }
      let urlSet = Set(packageUrls).subtracting(masterList)

      completed(.success([URL](urlSet)))
    }
  }
}
