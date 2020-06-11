import PackageListValidator
#if !os(watchOS)
  import XCTest

  final class GitHubResolverTests: XCTestCase {
    func testPackageURL() {
      let repoName = UUID().uuidString
      let ownerName = UUID().uuidString
      let branch = UUID().uuidString
      let resultURL = URL.fileRandom()
      let gitURL = URL.fileRandom().appendingPathComponent(ownerName).appendingPathComponent(repoName)
      let expBuilder = expectation(description: "builder")
      let builder = MockURLBuilder(resultURL: resultURL, onURL: { repo, filename in
        XCTAssertEqual(filename, GitHubResolver.packageFileName)
        XCTAssertEqual(repo.userName, ownerName)
        XCTAssertEqual(repo.repositoryName, repoName)
        XCTAssertEqual(repo.branchName, branch)
        expBuilder.fulfill()
      })
      let resolver = GitHubResolver(branchQuery: JustBranchQuery(branchName: branch), rawUrlBuilder: builder)
      let expPackageURL = expectation(description: "package")
      resolver.packageUrl(for: gitURL).done { url in
        XCTAssertEqual(url, resultURL)
        expPackageURL.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }
  }
#endif
