import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct GitHubRepo: Codable {
  public init (defaultBranch : String) {
    self.defaultBranch = defaultBranch
  }
  public let defaultBranch: String

  // swiftlint:disable:next nesting
  enum CodingKeys: String, CodingKey {
    case defaultBranch = "default_branch"
  }
}

public struct GitHubDefaultBranchQuery<SessionType: Session>: DefaultBranchQuery {
  public init(session: SessionType, decoder : JSONDecoder, baseURL: URL? = nil, gitHubUserName : String? = nil, gitHubToken : String? = nil) {
    self.decoder = decoder
    self.session = session
    self.apiBaseURL = baseURL ?? GitHubResolver.defaultAPIBaseURL
    self.gitHubUserName = gitHubUserName ?? Configuration.default.gitHubUserName
    self.gitHubToken = gitHubUserName ?? Configuration.default.gitHubToken
  }


  
  public let apiBaseURL : URL
  public let decoder: JSONDecoder
  public let session: SessionType
  public let gitHubToken : String?
  public let gitHubUserName : String?
  public func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void)) {
    let url = apiBaseURL.appendingPathComponent(owner).appendingPathComponent(repo)
    var urlRequest = session.request(withURL: url)
    #warning("use the configuration rather environment")
    if let token = self.gitHubToken,
      let username = self.gitHubUserName {
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
  public init (decoder : JSONDecoder = JSONDecoder()) {
    self.decoder = decoder
    self.session = URLSession(configuration: Configuration.default.config)
    self.apiBaseURL = GitHubResolver.defaultAPIBaseURL
    self.gitHubToken = Configuration.default.gitHubToken
    self.gitHubUserName = Configuration.default.gitHubUserName
  }
}
