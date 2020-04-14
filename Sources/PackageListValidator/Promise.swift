import Foundation
import PromiseKit

//  /**
//   Filters repositories based what is not listen in the master list.
//   - Parameter packageUrls: current package urls
//   - Parameter includingMaster: to not filter all repository url and just verify all package URLs
//   */
//  static func filterRepos(_: [URL], withSession _: URLSession, includingMaster _: Bool, _: @escaping ((Result<[URL], Error>) -> Void)) {}

//  static func parseRepos(
// _ packageUrls: [URL], withSession session: URLSession, usingDecoder decoder: JSONDecoder) -> Promise<[SwiftPackageReport]> {
//    let reporter = SwiftPackageReporter()
//    let promises = packageUrls.map {
//      reporter.verifyPackage(at: $0, withSession: session, usingDecoder: decoder)
//    }
//
//    return when(fulfilled: promises)
//    // return when(fulfilled: promises)
//  }

//  /**
//   Based on the directories passed and command line arguments, find the `packages.json` url.
//   - Parameter directoryURLs: directory url to search for `packages.json` file
//   - Parameter arguments: Command Line arguments which may contain a path to a `packages.json` file.
//   */
//  static func url(packagesFromDirectories directoryURLs: [URL], andArguments arguments: [String]) -> URL? {
//    let possiblePackageURLs = arguments.dropFirst().compactMap {
// URL(fileURLWithPath: $0) } + directoryURLs.map { $0.appendingPathComponent("packages.json") }
//    return possiblePackageURLs.first(where: { FileManager.default.fileExists(atPath: $0.path) })
//  }
