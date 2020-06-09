import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct SwiftPackageReporter {
  let downloader: PackageDownloader
  let parser: PackageParser = ProcessPackageParser()
  let logger: ((SwiftPackageReport) -> Void)?
  func verifyPackage(at gitURL: URL, withSession session: URLSession, usingDecoder decoder: JSONDecoder) -> Promise<SwiftPackageReport> {
    var promise = firstly {
      self.downloader.download(gitURL, withSession: session)
    }.then { downloadURL in
      self.parser.verifyPackageDump(at: downloadURL, withDecoder: decoder)
    }.map { detail in
      SwiftPackageReport(url: gitURL, result: .success(detail))
    }.recover(only: PackageError.self) { error -> Guarantee<SwiftPackageReport> in
      Guarantee {
        $0(SwiftPackageReport(url: gitURL, result: .failure(error)))
      }
    }

    if let logger = self.logger {
      promise = promise.then { report -> Promise<Promise<SwiftPackageReport>.T> in
        logger(report)
        return Promise.value(report)
      }
    }

    return promise
  }
}

public extension SwiftPackageReporter {
  func parseRepos(_ packageUrls: [URL], withSession session: URLSession, usingDecoder decoder: JSONDecoder) -> Promise<[SwiftPackageReport]> {
    let promises = packageUrls.map {
      self.verifyPackage(at: $0, withSession: session, usingDecoder: decoder)
    }

    return when(fulfilled: promises)
  }
}
