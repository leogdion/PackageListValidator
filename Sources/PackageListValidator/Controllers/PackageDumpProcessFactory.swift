import Foundation

/**
 Creates a `Process` for dump the package metadata.
 */
public struct PackageDumpProcessFactory: PackageDumpProcessFactoryProtocol {
  public init() {}
  /**
   Creates a `Process` for dump the package metadata.
   - Parameter packageDirectoryURL: File URL to Package
   - Parameter outputTo: standard output pipe
   - Parameter errorsTo: error pipe
   */
  public func dumpPackageProcessAt(_ packageDirectoryURL: URL, outputTo pipe: Pipe, errorsTo errorPipe: Pipe) -> Process {
    let process = Process()
    if #available(OSX 10.13, *) {
      process.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
    } else {
      process.launchPath = "/usr/bin/swift"
    }
    process.arguments = ["package", "dump-package"]
    if #available(OSX 10.13, *) {
      process.currentDirectoryURL = packageDirectoryURL
    } else {
      process.currentDirectoryPath = packageDirectoryURL.path
    }
    process.standardOutput = pipe
    process.standardError = errorPipe
    return process
  }
}
