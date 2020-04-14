import Foundation
//    // Make sure there are no dupes (no dupe variants w/ .git and w/o, no case differences)
//       print("Checking for duplicate packages.")
//         let urlCounts = Dictionary(grouping: packageUrls.enumerated()) {
//           URL(string: $0.element.absoluteString.lowercased())!
//         }.mapValues { $0.map { $0.offset } }.filter { $0.value.count > 1 }
//
//         guard urlCounts.count == 0 else {
//           print("Error: Duplicate URLs:\n\(urlCounts)")
//           throw NotImplementError()
//         }
//      return Promise.value(())
public struct UniqueListValidator: ListValidator {
  public static let errorDescription = "Duplicate URLs"

  public func invalidUrls(fromUrls urls: [URL]) -> [URL] {
    [URL](Dictionary(grouping: urls.enumerated()) {
      URL(string: $0.element.absoluteString.lowercased())!
              }.mapValues { $0.map { $0.offset } }.filter { $0.value.count > 1 }.keys)
  }

  public static let key = "unique"
}
