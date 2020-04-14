import Foundation
import PromiseKit

public protocol TemporaryDataStorage {
  func directoryUrl(forSavingData data: Data) throws -> URL
}

public struct TemporaryDirDataStorage: TemporaryDataStorage {
  public func directoryUrl(forSavingData data: Data) throws -> URL {
    let temporaryDirectoryURL: URL
    temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
    let outputDirURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: outputDirURL, withIntermediateDirectories: false, attributes: nil)
    try data.write(to: outputDirURL.appendingPathComponent("Package.swift"), options: .atomic)
    return outputDirURL
  }
}

public protocol PackageDownloader {
  func download(_ packageSwiftURL: URL, withSession session: URLSession) -> Promise<URL>
}

public struct TemporaryPackageDownloader: PackageDownloader {
  let urlFetcher: PackageUrlFetcherProtocol = PackageUrlFetcher()
  let tempDataStorage: TemporaryDataStorage = TemporaryDirDataStorage()

  public func download(_ packageSwiftURL: URL, withSession session: URLSession) -> Promise<URL> {
    urlFetcher.getPackageSwiftURL(for: packageSwiftURL).then { url in
      Promise<Data> { resolver in
        // debugPrint("Downloading \(url)...")
        session.dataTask(with: url) {
          resolver.resolve($2, $0)
          // debugPrint("Downloaded \(url)...")
        }.resume()
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
