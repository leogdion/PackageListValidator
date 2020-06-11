import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class JustBranchQueryTests: XCTestCase {
    func testBranch() {
      let expected = UUID().uuidString
      let query = JustBranchQuery(branchName: expected)
      let exp = expectation(description: "default branch called")
      query.defaultBranchName(forRepoName: UUID().uuidString, withOwner: UUID().uuidString).done {
        XCTAssertEqual($0, expected)
        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }
  }
#endif
