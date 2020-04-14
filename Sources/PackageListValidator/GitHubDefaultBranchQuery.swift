import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

struct GitHubDefaultBranchQuery: DefaultBranchQuery {
  struct GitHubRepo: Codable {
    let defaultBranch: String

    // swiftlint:disable:next nesting
    enum CodingKeys: String, CodingKey {
      case defaultBranch = "default_branch"
    }
  }

  static let defaultAPIBaseURL = URL(string: "https://api.github.com/repos")!
  let apiBaseURL = defaultAPIBaseURL
  let decoder: JSONDecoder
  let session: URLSession
  func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void)) {
    let url = apiBaseURL.appendingPathComponent(owner).appendingPathComponent(repo)
    var urlRequest = URLRequest(url: url)
    if let token = ProcessInfo.processInfo.environment["GITHUB_API_TOKEN"],
      let username = ProcessInfo.processInfo.environment["GITHUB_API_USERNAME"] {
      let userPasswordString = "\(username):\(token)"
      if let userPasswordData = userPasswordString.data(using: .utf8) {
        let base64EncodedCredential = userPasswordData.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        urlRequest.addValue(authString, forHTTPHeaderField: "Authorization")
      }
    }
    session.dataTask(with: urlRequest) { data, _, error in
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
    }.resume()
  }
}
