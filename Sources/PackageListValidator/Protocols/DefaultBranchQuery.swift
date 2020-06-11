import PromiseKit

/**
 Returns the default branch for the repository.
 */
public protocol DefaultBranchQuery {
  /**
   Returns the default branch for the repository.
    - Parameter repo: Repository Name
   - Parameter owner: Repositry Owner
   - Parameter completed: Callback for when a result is received.
   */
  func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void))
}

public extension DefaultBranchQuery {
  func defaultBranchName(forRepoName repo: String, withOwner owner: String) -> Promise<String> {
    Promise { resolver in
      self.defaultBranchName(forRepoName: repo, withOwner: owner, resolver.resolve)
    }
  }
}
