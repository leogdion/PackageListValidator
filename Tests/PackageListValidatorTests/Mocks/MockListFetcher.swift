import Foundation
import PackageListValidator

struct MockListFetcher: ListFetcherProtocol {
  let result: Result<[URL], Error>
  func listWithSession<SessionType>(
    _: SessionType,
    usingDecoder _: JSONDecoder,
    _ completed: @escaping (Result<[URL], Error>) -> Void
  ) where SessionType: Session {
    completed(result)
  }
}
