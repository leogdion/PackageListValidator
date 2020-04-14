import ArgumentParser
import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

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
    let packagesJsonURL = packageListJsonURLParser.url(
      packagesFromDirectories: [
        currentDirectoryURL,
        URL(fileURLWithPath: #file).deletingLastPathComponent()
      ], andPath: path
    )

    // Based on arguments find the `package.json` file
    guard let url = packagesJsonURL else {
      print("Error: Unable to find packages.json to validate.")
      throw NotImplementError()
    }

    let packageUrls: [URL]
    do {
      let data = try Data(contentsOf: url)
      packageUrls = try decoder.decode([URL].self, from: data)
    } catch {
      Self.exit(withError: error)
    }
    let listValidators: [ListValidator] = [GitUrlListValidator(), SortedListValidator(), UniqueListValidator()]
    let listValidatorKeys = listValidators.map {
      $0.makeKey()
    }

    let results = listValidatorKeys.compactMap {
      $0.validator.validateUrls(packageUrls)
    }

    if let error = ListValidationError(errors: results) {
      Self.exit(withError: error)
    }

    print("Checking each url for valid package dump.")
    let filter = PackageFilter(type: .none)
    let reporter = SwiftPackageReporter()
    _ = firstly {
      filter.filterRepos(packageUrls, withSession: session, usingDecoder: decoder)
    }.then { urls in
      reporter.parseRepos(urls, withSession: session, usingDecoder: decoder)
    }.done { reports in
      Self.exit(withError: ReportError(reports))
    }

    RunLoop.main.run()
  }
}
