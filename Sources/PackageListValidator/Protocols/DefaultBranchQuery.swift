import PromiseKit

public protocol DefaultBranchQuery {
  func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void))
}

public extension DefaultBranchQuery {
  func defaultBranchName(forRepoName repo: String, withOwner owner: String) -> Promise<String> {
    Promise { resolver in
      self.defaultBranchName(forRepoName: repo, withOwner: owner, resolver.resolve)
    }
  }
}
