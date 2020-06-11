import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol ListFetcherProtocol {
  func listWithSession<SessionType: Session>(
    _ session: SessionType,
    usingDecoder decoder: JSONDecoder,
    _ completed: @escaping (Result<[URL], Error>) -> Void
  )
}
