import Foundation
import PromiseKit

public protocol PackageDumpProcessFactoryProtocol {
  func dumpPackageProcessAt(_ packageDirectoryURL: URL, outputTo pipe: Pipe, errorsTo errorPipe: Pipe) -> Process
}
public struct PackageDumpProcessFactory : PackageDumpProcessFactoryProtocol {
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
protocol PackageParser {
  func verifyPackageDump(at directoryURL: URL, withDecoder decoder: JSONDecoder) -> Promise<RepoDetail>
}
public struct ProcessPackageParser {
  let processFactory : PackageDumpProcessFactoryProtocol = PackageDumpProcessFactory()
  let maximumProcesses = 3
  let processTimeout = 10.0
  let processSemaphore : DispatchSemaphore
  
  public init () {
    processSemaphore = DispatchSemaphore(value: maximumProcesses)
  }
  func verifyPackageDump(at directoryURL: URL, withDecoder decoder: JSONDecoder) -> Promise<RepoDetail> {
      let pipe = Pipe()
      let errorPipe = Pipe()
    let process = processFactory.dumpPackageProcessAt(directoryURL, outputTo: pipe, errorsTo: errorPipe)
      let processPromise = Promise<RepoDetail> { resolver in
        process.terminationHandler = {
          _ in
          
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

          let repoDetail: RepoDetail
          do {
            repoDetail = try RepoDetail(package: package)
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
      
    DispatchQueue.main.asyncAfter(deadline: .now() + self.processTimeout){
        process.terminate()
      }
      
      return processPromise
      
      
  //  debugPrint(directoryURL.lastPathComponent)
  //    let timeout =
  //    after(seconds: processTimeout)
  //
  //    return  timeout.then({
  //      return Promise<RepoUrlReport>.init(error: PackageError.dumpTimeout)
  //      })

      
    }
}
