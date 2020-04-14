import Foundation
import PromiseKit

public struct ProcessPackageParser: PackageParser {
  let processFactory: PackageDumpProcessFactoryProtocol = PackageDumpProcessFactory()
  let maximumProcesses = 3
  let processTimeout = 10.0
  let processSemaphore: DispatchSemaphore

  public init() {
    processSemaphore = DispatchSemaphore(value: maximumProcesses)
  }

  func verifyPackageDump(at directoryURL: URL, withDecoder decoder: JSONDecoder) -> Promise<SwiftPackageDetails> {
    let pipe = Pipe()
    let errorPipe = Pipe()
    let process = processFactory.dumpPackageProcessAt(directoryURL, outputTo: pipe, errorsTo: errorPipe)
    let processPromise = Promise<SwiftPackageDetails> { resolver in
      process.terminationHandler = { _ in

        guard process.terminationStatus == 0 else {
          let error: PackageError
          if process.terminationStatus == 15 {
            error = .dumpTimeout
          } else {
            error = .badDump(String(data: errorPipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8))
          }
          debugPrint(error)
          resolver.reject(error)
          self.processSemaphore.signal()
          return
        }

        let package: Package
        do {
          package = try decoder.decode(Package.self, from: pipe.fileHandleForReading.readDataToEndOfFile())
        } catch {
          resolver.reject(PackageError.decodingError(error))
          self.processSemaphore.signal()
          return
        }

        let repoDetail: SwiftPackageDetails
        do {
          repoDetail = try SwiftPackageDetails(package: package)
        } catch {
          resolver.reject(error)
          self.processSemaphore.signal()
          return
        }

        resolver.fulfill(repoDetail)
        self.processSemaphore.signal()
      }
    }

    processSemaphore.wait()
    process.launch()

    DispatchQueue.main.asyncAfter(deadline: .now() + processTimeout) {
      process.terminate()
    }

    return processPromise
  }
}
