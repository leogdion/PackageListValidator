import PackageListValidator
#if !os(watchOS)
  import PromiseKit
  import XCTest

  final class GitHubDefaultBranchQueryTests: XCTestCase {
    func testDefaultBranchName() {
      let branch = UUID().uuidString

      let session = MockSession(result: .success(GitHubRepo(defaultBranch: branch)), onURL: nil)
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
      let session = MockSession<GitHubRepo>(result: .failure(error), onURL: nil)
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

      let session = MockSession(result: .success(GitHubRepo(defaultBranch: branch)), onURL: nil)
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
      let session = MockSession<GitHubRepo>(result: nil, onURL: nil)
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
