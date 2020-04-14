import Foundation
import PromiseKit

public protocol PackageUrlFetcherProtocol {
  func getPackageSwiftURL(for gitURL: URL) -> Promise<URL>
}
