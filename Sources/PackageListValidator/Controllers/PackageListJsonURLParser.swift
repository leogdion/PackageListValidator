import Foundation

public struct PackageListJsonURLParser: PackageListJsonURLParserProtocol {
  public let fileExists: (String) -> Bool

  public init(fileExists: @escaping (String) -> Bool = FileManager.default.fileExists) {
    self.fileExists = fileExists
  }

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
    return possiblePackageURLs.first(where: { self.fileExists($0.path) })
  }
}
