import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/**
 Fetches an Array of repository URLs from a JSON file.
 */
public protocol ListFetcherProtocol {
  /**
   Fetches an Array of repository URLs from a JSON file.
   - Parameter session: The Session to build URL requests from.
   - Parameter decoder: The JSONDecoder.
   - Parameter completed: Callback for when the URLs are decoded.
   */
  func listWithSession<SessionType: Session>(
    _ session: SessionType,
    usingDecoder decoder: JSONDecoder,
    _ completed: @escaping (Result<[URL], Error>) -> Void
  )
}
