import Foundation
import PromiseKit

public protocol PackageUrlFetcherProtocol {
  func getPackageSwiftURL(for gitURL: URL, resolvingWith branchQuery: DefaultBranchQuery) -> Promise<URL>
}
