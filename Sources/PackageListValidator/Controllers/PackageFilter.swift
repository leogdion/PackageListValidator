import Foundation
import PromiseKit

public struct PackageFilter: PackageFilterProtocol {
  public let type: PackageFilterType

  public init(type: PackageFilterType) {
    self.type = type
  }

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
