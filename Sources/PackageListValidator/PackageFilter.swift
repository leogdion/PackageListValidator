import Foundation
import PromiseKit

public protocol ListFetcher {
  func listWithSession(_ session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
}

public enum PackageFilterType {
  case none
  case diffWith(ListFetcher)
}

public protocol PackageFilterProtocol {
  func filterRepos(_ packageUrls: [URL], withSession session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
}

public extension PackageFilterProtocol {
  func filterRepos(_ packageUrls: [URL], withSession session: URLSession, usingDecoder decoder: JSONDecoder) -> Promise<[URL]> {
    Promise<[URL]> { resolver in
      self.filterRepos(packageUrls, withSession: session, usingDecoder: decoder) {
        resolver.resolve($0)
      }
    }
  }
}

public struct PackageFilter: PackageFilterProtocol {
  public let type: PackageFilterType

  public func filterRepos(_ packageUrls: [URL], withSession session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void) {
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
