import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/**
 Returns the default branch for the repository by calling the GitHub API.
 */
public struct GitHubDefaultBranchQuery<SessionType: Session>: DefaultBranchQuery {
  public init(session: SessionType, decoder: JSONDecoder, baseURL: URL? = nil, gitHubUserName: String? = nil, gitHubToken _: String? = nil) {
    self.decoder = decoder
    self.session = session
    apiBaseURL = baseURL ?? GitHubResolver.defaultAPIBaseURL
    self.gitHubUserName = gitHubUserName ?? Configuration.default.gitHubUserName
    gitHubToken = gitHubUserName ?? Configuration.default.gitHubToken
  }

  public let apiBaseURL: URL
  public let decoder: JSONDecoder
  public let session: SessionType
  public let gitHubToken: String?
  public let gitHubUserName: String?

  /**
   Returns the default branch for the repository from the GitHub API.
    - Parameter repo: Repository Name
   - Parameter owner: Repositry Owner
   - Parameter completed: Callback for when a result is received.
   */
  public func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void)) {
    let url = apiBaseURL.appendingPathComponent(owner).appendingPathComponent(repo)
    var urlRequest = session.request(withURL: url)
    if let token = gitHubToken,
      let username = gitHubUserName {
      let userPasswordString = "\(username):\(token)"
      if let userPasswordData = userPasswordString.data(using: .utf8) {
        let base64EncodedCredential = userPasswordData.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        urlRequest.addHeader(withValue: authString, forField: "Authorization")
      }
    } else {
      completed(.success("master"))
      return
    }
    session.begin(request: urlRequest) { data, _, error in
      if let error = error {
        completed(.failure(error))
        return
      }

      guard let data = data else {
        completed(.failure(InvalidCallingConvention))
        return
      }
      let result = Result { try self.decoder.decode(GitHubRepo.self, from: data) }
      completed(result.map { $0.defaultBranch })
    }
  }
}

public extension GitHubDefaultBranchQuery where SessionType == URLSession {
  init(decoder: JSONDecoder = JSONDecoder()) {
    self.decoder = decoder
    session = URLSession(configuration: Configuration.default.config)
    apiBaseURL = GitHubResolver.defaultAPIBaseURL
    gitHubToken = Configuration.default.gitHubToken
    gitHubUserName = Configuration.default.gitHubUserName
  }
}
