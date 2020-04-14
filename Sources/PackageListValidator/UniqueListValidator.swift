import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
  public typealias URLSession = FoundationNetworking.URLSession
#endif

public struct UniqueListValidator: ListValidator {
  public static let errorDescription = "Duplicate URLs"

  public func invalidUrls(fromUrls urls: [URL]) -> [URL] {
    [URL](Dictionary(grouping: urls.enumerated()) {
      URL(string: $0.element.absoluteString.lowercased())!
              }.mapValues { $0.map { $0.offset } }.filter { $0.value.count > 1 }.keys)
  }

  public static let key = "unique"
}
