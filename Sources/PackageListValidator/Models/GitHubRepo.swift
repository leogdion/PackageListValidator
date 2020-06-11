/**
 Codable Data Structure for GitHub Repository API.
 */
public struct GitHubRepo: Codable {
  public init(defaultBranch: String) {
    self.defaultBranch = defaultBranch
  }

  /***
   The default branch returned by the GitHub API.
   */
  public let defaultBranch: String

  enum CodingKeys: String, CodingKey {
    case defaultBranch = "default_branch"
  }
}
