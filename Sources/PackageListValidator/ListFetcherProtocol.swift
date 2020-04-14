import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol ListFetcherProtocol {
  func listWithSession(_ session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void)
}
