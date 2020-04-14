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
    session.dataTask(with: url) { data, _, error in
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
