import Foundation
import PromiseKit

public protocol ListFetcherProtocol {
  func listWithSession(_ session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
}

public struct ListFetcher : ListFetcherProtocol {
  let listURL : URL
  public func listWithSession(_ session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void) {
    
    session.dataTask(with: listURL) { (data, _, error) in
      if let error = error {
        completed(.failure(error))
      } else if let data = data {
        completed(Result { try decoder.decode([URL].self, from: data) })
      } else {
        completed(.failure(PMKError.invalidCallingConvention))
      }
    }
  }
}

public enum PackageFilterType {
  case none
  case diffWith(ListFetcherProtocol)
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
