import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct TemporaryPackageDownloader: PackageDownloader {
  let branchQuery: DefaultBranchQuery
  let urlFetcher: PackageUrlFetcherProtocol
  let tempDataStorage: TemporaryDataStorage
  let delay: TimeInterval

  public init(branchQuery: DefaultBranchQuery,
              urlFetcher: PackageUrlFetcherProtocol = PackageUrlFetcher(),
              tempDataStorage: TemporaryDataStorage = TemporaryDirDataStorage(), delay: TimeInterval = 10.0) {
    self.branchQuery = branchQuery
    self.urlFetcher = urlFetcher
    self.tempDataStorage = tempDataStorage
    self.delay = delay
  }

  public func download<SessionType: Session>(_ packageSwiftURL: URL, withSession session: SessionType) -> Promise<URL> {
    urlFetcher.getPackageSwiftURL(for: packageSwiftURL, resolvingWith: branchQuery).then { url in
      Promise<Data> { resolver in
        let request = session.request(withURL: url)
        session.begin(request: request) {
          resolver.resolve($2, $0)
        }
      }
    }.then { data in
      Promise<URL> { resolver in
        let result = Result { try self.tempDataStorage.directoryUrl(forSavingData: data) }
        resolver.resolve(result)
      }
    }.then { url in

      after(seconds: self.delay).map {
        url
      }
    }
  }
}
