import PackageListValidator
#if !os(watchOS)
  import PromiseKit
  import XCTest

  extension Result {
    var error: Failure? {
      switch self {
      case let .failure(error): return error
      default: return nil
      }
    }
  }

  struct MockRequest: SessionRequest {
    let url: URL
    var body: Data?
    var headers = [String: String]()
    var method: String?

    mutating func addHeader(withValue value: String, forField field: String) {
      headers[field] = value
    }
  }

  struct MockResponse: Response {
    var httpStatusCode: Int?
  }

  struct MockError<Value: Equatable>: Error {
    let value: Value
  }

  extension MockError {
    func assertEqual(_ other: Error?) {
      guard let mockError = other as? Self else {
        XCTFail("")
        return
      }

      XCTAssertEqual(mockError.value, value)
    }
  }

  struct MockTask: Task {}

  struct MockSession<Success: Encodable>: Session {
    let result: Result<Success, Error>?
    func request(withURL url: URL) -> MockRequest {
      MockRequest(url: url)
    }

    func begin(request _: MockRequest, _ completionHandler: @escaping (Data?, MockResponse?, Error?) -> Void) -> Task {
      guard let result = self.result else {
        completionHandler(nil, nil, nil)
        return MockTask()
      }
      let data: Data?
      let error: Error?
      let encoder = JSONEncoder()
      let dataResult = result.flatMap { success in
        Result {
          try encoder.encode(success)
        }
      }
      do {
        data = try dataResult.get()
        error = nil
      } catch let caughtError {
        error = caughtError
        data = nil
      }
      completionHandler(data, nil, error)
      return MockTask()
    }
  }

  final class GitHubDefaultBranchQueryTests: XCTestCase {
    func testDefaultBranchName() {
      let branch = UUID().uuidString

      let session = MockSession(result: .success(GitHubRepo(defaultBranch: branch)))
      let repoName = UUID().uuidString
      let owner = UUID().uuidString
      let token = UUID().uuidString
      let userName = UUID().uuidString
      let query = GitHubDefaultBranchQuery(session: session, decoder: JSONDecoder(), gitHubUserName: userName, gitHubToken: token)

      let exp = expectation(description: "does fetch branch name")
      query.defaultBranchName(forRepoName: repoName, withOwner: owner) { result in
        XCTAssertEqual(try? result.get(), branch)

        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }

    func testPassedError() {
      let error = MockError(value: UUID())
      let session = MockSession<GitHubRepo>(result: .failure(error))
      let repoName = UUID().uuidString
      let owner = UUID().uuidString
      let token = UUID().uuidString
      let userName = UUID().uuidString
      let query = GitHubDefaultBranchQuery(session: session, decoder: JSONDecoder(), gitHubUserName: userName, gitHubToken: token)

      let exp = expectation(description: "does fetch branch name")
      query.defaultBranchName(forRepoName: repoName, withOwner: owner) { result in
        error.assertEqual(result.error)
        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }

    func testMaster() {
      let branch = UUID().uuidString

      let session = MockSession(result: .success(GitHubRepo(defaultBranch: branch)))
      let repoName = UUID().uuidString
      let owner = UUID().uuidString
      let query = GitHubDefaultBranchQuery(session: session, decoder: JSONDecoder())

      let exp = expectation(description: "does fetch branch name")
      query.defaultBranchName(forRepoName: repoName, withOwner: owner) { result in
        XCTAssertEqual(try? result.get(), "master")

        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }

    func testEmpty() {
      let session = MockSession<GitHubRepo>(result: nil)
      let repoName = UUID().uuidString
      let owner = UUID().uuidString
      let token = UUID().uuidString
      let userName = UUID().uuidString
      let query = GitHubDefaultBranchQuery(session: session, decoder: JSONDecoder(), gitHubUserName: userName, gitHubToken: token)

      let exp = expectation(description: "does fetch branch name")
      query.defaultBranchName(forRepoName: repoName, withOwner: owner) { result in
        let castError = result.error as? PMKError
        switch castError {
        case .some(.invalidCallingConvention):
          XCTAssert(true)
        default:
          XCTFail("Invalid Error Type")
        }
        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }

    func testDefault() {
      let query = GitHubDefaultBranchQuery()
      XCTAssertEqual(query.apiBaseURL, GitHubResolver.defaultAPIBaseURL)
      XCTAssertNil(query.gitHubToken)
      XCTAssertNil(query.gitHubUserName)
    }
  }
#endif
