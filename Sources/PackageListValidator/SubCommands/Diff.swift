import ArgumentParser
import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct Diff: ParsableCommand {
  public static var configuration
    = CommandConfiguration(abstract: "Verify only packages which are not contained in the current master list.")

  @Argument(default: "packages.json", help: "Path to the JSON file containing the repository list.")
  var path: String?

  public init() {}

  public func run() throws {
    let listRepoSpecs = RepoSpecification(repositoryName: "SwiftPackageIndex", userName: "MasterPackageList", branchName: "master")
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
      throw ValidationError("Unable to find packages.json to validate.")
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
    let reporter = SwiftPackageReporter(downloader: TemporaryPackageDownloader(branchQuery: GitHubDefaultBranchQuery()), logger: nil)
    _ = firstly {
      filter.filterRepos(packageUrls, withSession: session, usingDecoder: decoder)
    }.map { urls in
      print(urls.map { $0.absoluteString }.joined(separator: "\n"))
      return urls
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
