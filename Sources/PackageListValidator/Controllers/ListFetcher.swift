import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct ListFetcher: ListFetcherProtocol {
  public let listURL: URL
  public init(listURL: URL) {
    self.listURL = listURL
  }

  public func listWithSession<SessionType: Session>(
    _ session: SessionType,
    usingDecoder decoder: JSONDecoder,
    _ completed: @escaping (Result<[URL], Error>) -> Void
  ) {
    let request = session.request(withURL: listURL)
    session.begin(request: request) { data, _, error in
      if let error = error {
        completed(.failure(error))
      } else if let data = data {
        completed(Result { try decoder.decode([URL].self, from: data) })
      } else {
        completed(.failure(InvalidCallingConvention))
      }
    }
  }
}
