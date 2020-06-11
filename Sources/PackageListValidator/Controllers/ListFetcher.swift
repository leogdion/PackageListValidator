import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/**
 Fetches an Array of repository URLs from a JSON file.
 */
public struct ListFetcher: ListFetcherProtocol {
  public let listURL: URL
  public init(listURL: URL) {
    self.listURL = listURL
  }

  /**
   Fetches an Array of repository URLs from a JSON file.
   - Parameter session: The Session to build URL requests from.
   - Parameter decoder: The JSONDecoder.
   - Parameter completed: Callback for when the URLs are decoded.
   */
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
