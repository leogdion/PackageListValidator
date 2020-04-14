import Foundation

public struct GitUrlListValidator: ListValidator {
  public static var errorDescription = "Missing .git extension"

  public func invalidUrls(fromUrls urls: [URL]) -> [URL] {
    urls.filter { $0.pathExtension != "git" }
  }

  public static let key = "url"
}

//      return Promise.init { (resolver) in
//        print("Checking all urls are valid.")
//        let invalidUrls = packageUrls.filter { $0.pathExtension != "git" }
//
//        guard invalidUrls.count == 0 else {
//          print("Invalid URLs missing .git extension: \(invalidUrls)")
//          //throw NotImplementError()
//          resolver.resolve(nil, NotImplementError())
//          return
//        }
//        resolver.resolve((), nil)
//      }
