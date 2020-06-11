import Foundation

/**
 Creates a `Process` for dump the package metadata.
 */
public protocol PackageDumpProcessFactoryProtocol {
  /**
   Creates a `Process` for dump the package metadata.
   - Parameter packageDirectoryURL: File URL to Package
   - Parameter outputTo: standard output pipe
   - Parameter errorsTo: error pipe
   */
  func dumpPackageProcessAt(_ packageDirectoryURL: URL, outputTo pipe: Pipe, errorsTo errorPipe: Pipe) -> Process
}
