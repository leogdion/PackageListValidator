import ArgumentParser
import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct Diff: ParsableCommand {
  @Argument(default: "packages.json")
  var path: String?

  public init() {}

  public func run() throws {
    let listRepoSpecs = RepoSpecification(repositoryName: "SwiftPMLibrary", userName: "daveverwer", branchName: "master")
    let rawUrlResolver = GitHubRawUrlBuilder()
    let listUrl = rawUrlResolver.url(basedOn: listRepoSpecs, forFileName: "packages.json")

    let session: URLSession = URLSession(configuration: Configuration.default.config)
    let decoder = JSONDecoder()
    let packageListJsonURLParser: PackageListJsonURLParserProtocol = PackageListJsonURLParser()
    let listValidators: [ListValidator] = [GitUrlListValidator(), SortedListValidator(), UniqueListValidator()]

    let currentDirectoryURL: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
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

    let errors = listValidators.compactMap {
      $0.validateUrls(packageUrls)
    }

    if let error = ListValidationError(errors: errors) {
      Self.exit(withError: error)
    }

    print("Checking each url for valid package dump.")
    let filter = PackageFilter(type: .diffWith(ListFetcher(listURL: listUrl)))
    let reporter = SwiftPackageReporter()
    _ = firstly {
      filter.filterRepos(packageUrls, withSession: session, usingDecoder: decoder)
    }.then { urls in
      reporter.parseRepos(urls, withSession: session, usingDecoder: decoder)
    }.done { reports in
      let error = ReportError(reports)

      if error == nil {
        print("Validation Successful.")
      }

      Self.exit(withError: error)
    }

    RunLoop.main.run()
  }
}
