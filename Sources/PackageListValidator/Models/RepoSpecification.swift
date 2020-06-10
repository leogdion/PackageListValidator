public struct RepoSpecification {
  public let repositoryName: String
  public let userName: String
  public let branchName: String
  public init(
    repositoryName: String,
    userName: String,
    branchName: String
  ) {
    self.repositoryName = repositoryName
    self.userName = userName
    self.branchName = branchName
  }
}
