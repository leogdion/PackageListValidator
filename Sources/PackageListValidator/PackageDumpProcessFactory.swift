import Foundation

public struct PackageDumpProcessFactory: PackageDumpProcessFactoryProtocol {
  public func dumpPackageProcessAt(_ packageDirectoryURL: URL, outputTo pipe: Pipe, errorsTo errorPipe: Pipe) -> Process {
    let process = Process()
    process.launchPath = "/usr/bin/swift"
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
