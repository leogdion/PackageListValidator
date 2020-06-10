import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct TemporaryPackageDownloader: PackageDownloader {
  let branchQuery: DefaultBranchQuery
  let urlFetcher: PackageUrlFetcherProtocol = PackageUrlFetcher()
  let tempDataStorage: TemporaryDataStorage = TemporaryDirDataStorage()

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
      after(seconds: 10.0).map {
        url
      }
    }
  }
}
