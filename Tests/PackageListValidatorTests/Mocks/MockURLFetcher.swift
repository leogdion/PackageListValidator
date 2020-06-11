import Foundation
import PackageListValidator
import PromiseKit

struct MockURLFetcher: PackageUrlFetcherProtocol {
  let resultURL: URL
  let onBranch: ((String) -> Void)?
  func getPackageSwiftURL(for _: URL, resolvingWith branchQuery: DefaultBranchQuery) -> Promise<URL> {
    branchQuery.defaultBranchName(forRepoName: UUID().uuidString, withOwner: UUID().uuidString).map { branchName in
      self.onBranch?(branchName)
      return self.resultURL
    }
  }
}
