import ArgumentParser
import Foundation
import PromiseKit

struct NotImplementError: Error {}

public protocol PackageListJsonURLParserProtocol {
  /**
   Based on the directories passed and command line arguments, find the `packages.json` url.
   - Parameter directoryURLs: directory url to search for `packages.json` file
   - Parameter arguments: Command Line arguments which may contain a path to a `packages.json` file.
   */
  func url(packagesFromDirectories directoryURLs: [URL], andPath path: String?) -> URL?
}

public struct PackageListJsonURLParser: PackageListJsonURLParserProtocol {
  /**
   Based on the directories passed and command line arguments, find the `packages.json` url.
   - Parameter directoryURLs: directory url to search for `packages.json` file
   - Parameter arguments: Command Line arguments which may contain a path to a `packages.json` file.
   */
  public func url(packagesFromDirectories directoryURLs: [URL], andPath path: String?) -> URL? {
    if let url = path.flatMap(URL.init(fileURLWithPath:)) {
      return url
    }
    let possiblePackageURLs = directoryURLs.map { $0.appendingPathComponent("packages.json") }
    return possiblePackageURLs.first(where: { FileManager.default.fileExists(atPath: $0.path) })
  }
}

public struct Configuration {
  public static let `default` = Configuration()

  public let semaphoreCount = 3
  public let timeoutIntervalForRequest = 3000.0
  public let timeoutIntervalForResource = 6000.0

  // base url for github raw files
  public let rawURLComponentsBase = URLComponents(string: "https://raw.githubusercontent.com")!

  public let masterPackageGitHubPath = "daveverwer/SwiftPMLibrary/master/packages.json"
  // master package list to compare against
  public var masterPackageList: URL? {
    rawURLComponentsBase.url?.appendingPathComponent(masterPackageGitHubPath)
  }

  public let logEveryCount = 10
  public let httpMaximumConnectionsPerHost = 10
  public let displayProgress = false
  public let processTimeout = 50.0

  public var config: URLSessionConfiguration {
    let config: URLSessionConfiguration = .default
    config.timeoutIntervalForRequest = timeoutIntervalForRequest
    config.timeoutIntervalForResource = timeoutIntervalForResource
    config.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
    return config
  }

  private init() {}
}

// func invalidUrls (_ packageUrls : [URL]) -> Promise<Void> {
//  Promise { (resolve) in
//    DispatchQueue.global().async {
//      print("Checking all urls are valid.")
//      let invalidUrls = packageUrls.filter { $0.pathExtension != "git" }
//
//      guard invalidUrls.count == 0 else {
//        print("Invalid URLs missing .git extension: \(invalidUrls)")
//        resolve.reject(NotImplementError())
//        return
//      }
//      resolve.fulfill()
//
//    }
//
//
//  }
// }

public protocol ListValidator {
  static var key: String { get }

  func validateUrls(_ urls: [URL]) -> Error?
}

extension ListValidator {
  func makeKey() -> ListValidatorKey {
    ListValidatorKey(id: Self.key, validator: self)
  }
}

public struct ListValidatorKey: Identifiable, Hashable {
  public static func == (lhs: ListValidatorKey, rhs: ListValidatorKey) -> Bool {
    lhs.id == rhs.id
  }

  public let id: String
  public let validator: ListValidator

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

public struct All: ParsableCommand {
  @Argument(default: "packages.json")
  var path: String?

  public init() {}

  public func run() throws {
    let decoder = JSONDecoder()
    let session: URLSession = URLSession(configuration: Configuration.default.config)

    let currentDirectoryURL: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
    let packageListJsonURLParser: PackageListJsonURLParserProtocol = PackageListJsonURLParser()
    // Find the "packages.json" file based on arguments, current directory, or the directory of the script
    let packagesJsonURL = packageListJsonURLParser.url(packagesFromDirectories: [currentDirectoryURL, URL(fileURLWithPath: #file).deletingLastPathComponent()], andPath: path)

    // Based on arguments find the `package.json` file
    guard let url = packagesJsonURL else {
      print("Error: Unable to find packages.json to validate.")
      throw NotImplementError()
    }

    let data = try! Data(contentsOf: url)
    let packageUrls = try! decoder.decode([URL].self, from: data)

    let listValidators = [ListValidator]()
    let listValidatorKeys = listValidators.map {
      $0.makeKey()
    }

    let results = Dictionary(uniqueKeysWithValues: listValidatorKeys.map {
      ($0, $0.validator.validateUrls(packageUrls))
    }).compactMapValues { $0 }

    // let semaphore = DispatchSemaphore(value: 0)
    // Make sure all urls contain the .git extension
    // let invalidUrlsPromise = invalidUrls(packageUrls)

//    firstly { () -> Promise<Void> in
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
//    }.then { resolver -> Promise<Void> in
//
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
//    }.then {_ -> Promise<Void> in
//      // Sort the array of urls
//      print("Checking packages are sorted.")
//      let sortedUrls = packageUrls.sorted {
//        $0.absoluteString.lowercased() < $1.absoluteString.lowercased()
//      }
//
//      // Verify that there are no differences between the current JSON and the sorted JSON
//      let unsortedUrls = zip(packageUrls, sortedUrls).enumerated().filter { $0.element.0 != $0.element.1 }.map {
//        ($0.offset, $0.element.0)
//      }
//
//      guard unsortedUrls.count == 0 else {
//        // If the sorting fails, save the sorted packages.json file
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = [.prettyPrinted]
//        let data = try! encoder.encode(sortedUrls)
//        let str = String(data: data, encoding: .utf8)!.replacingOccurrences(of: "\\/", with: "/")
//        let unescapedData = str.data(using: .utf8)!
//        let outputURL = url.deletingPathExtension().appendingPathExtension("sorted.json")
//        try! unescapedData.write(to: outputURL)
//        print("Error: Packages.json is not sorted correctly. Run this validation locally and replace packages.json with packages.sorted.json.")
//        throw NotImplementError()
//      }
//      return Promise.value(())
//    }.ensure {
//      semaphore.signal()
//    }.done {
//      print("done")
//    }
//
//    semaphore.wait()

    let semaphore = DispatchSemaphore(value: 0)
    print("Checking each url for valid package dump.")
    firstly {
      try ObsoleteValidator.filterRepos(packageUrls, withSession: session, usingDecoder: decoder, includingMaster: true)
    }.then { urls in
      ObsoleteValidator.parseRepos(urls, withSession: session, usingDecoder: decoder)
    }.done { _ in
      semaphore.signal()
    }

    RunLoop.main.run()
    semaphore.wait()
//      ObsoleteValidator.filterRepos(packageUrls, withSession: session, includingMaster: true)
//        .then {
//          ObsoleteValidator.parseRepos($0, withSession: session)
//        }.done {
//          print("Validation Succeeded.")
//        }

//    ObsoleteValidator.filterRepos(packageUrls, withSession: session, includingMaster: true) { result in
//      let packageUrls: [URL]
//      switch result {
//      case let .failure(error):
//        debugPrint(error)
//        throw NotImplementError()
//      case let .success(urls):
//        packageUrls = urls
//      }
//      print("Checking \(packageUrls.count) Packages...")
//      parseRepos(packageUrls, withSession: session) { errors in
//        for (url, error) in errors {
//          print(url, error)
//        }
//        if errors.count == 0 {
//          print("Validation Succeeded.")
//          return
//        } else {
//          print("Validation Failed")
//          let errorReport = [String: [PackageError]].init(grouping: errors.values, by: { $0.friendlyName }).mapValues { $0.count }
//          for report in errorReport {
//            print(report.value, report.key, separator: "\t")
//          }
//          print()
//          print("\(errors.count) Packages Failed")
//          throw NotImplementError()
//        }
//      }
//    }
  }
}

public struct Mine: ParsableCommand {
  @Argument(default: "Current Directory")
  var path: String?

  public init() {}
}

public struct Diff: ParsableCommand {
  @Argument(default: "packages.json")
  var path: String?

  public init() {}
}

public struct PackageListValidator: ParsableCommand {
  public static var configuration = CommandConfiguration(
    subcommands: [All.self, Mine.self, Diff.self])
  public init() {}
}
