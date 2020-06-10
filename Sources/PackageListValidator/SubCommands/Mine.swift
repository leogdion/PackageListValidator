import ArgumentParser
import Foundation

public struct Mine: ParsableCommand {
  public static var configuration
    = CommandConfiguration(abstract: "Verify the package in the directory specified or the current directory.")

  @Argument(default: nil, help: "The directory to verify if the Swift package is valid.")
  var directory: String?

  public init() {}

  public func run() throws {
    let parser: PackageParser = ProcessPackageParser()

    let decoder = JSONDecoder()

    let currentDirectoryURL: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
    let pathURL = directory.map {
      URL(fileURLWithPath: $0, isDirectory: true)
    }
    parser.verifyPackageDump(at: pathURL ?? currentDirectoryURL, withDecoder: decoder).catch {
      Self.exit(withError: $0)
    }.finally {
      print("Validation Successful.")
      Self.exit()
    }

    RunLoop.main.run()
  }
}
