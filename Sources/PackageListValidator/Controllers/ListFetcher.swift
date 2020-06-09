import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct ListFetcher: ListFetcherProtocol {
  let listURL: URL
  public func listWithSession(_ session: URLSession, usingDecoder decoder: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void) {
    let task = session.dataTask(with: listURL) { data, _, error in
      if let error = error {
        completed(.failure(error))
      } else if let data = data {
        completed(Result { try decoder.decode([URL].self, from: data) })
      } else {
        completed(.failure(InvalidCallingConvention))
      }
    }
    task.resume()
  }
}
