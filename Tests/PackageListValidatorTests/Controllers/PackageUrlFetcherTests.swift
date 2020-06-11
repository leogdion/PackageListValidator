import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class PackageUrlFetcherTests: XCTestCase {
    func testGetPackageNoHost() {
      let fetcher = PackageUrlFetcher()
      let url = URL.fileRandom()
      let string = UUID().uuidString
      let exp = expectation(description: "pacakge url")
      fetcher.getPackageSwiftURL(for: url, resolvingWith: JustBranchQuery(branchName: string)).catch(only: PackageError.self) { error in
        switch error {
        case let .invalidURL(actual):
          XCTAssertEqual(actual, url)
        default:
          XCTFail("invalid error")
        }
        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }

    func testGetPackageInvalidHost() {
      let fetcher = PackageUrlFetcher()
      let url = URL(string: "https://bitbucket.com")!
      let string = UUID().uuidString
      let exp = expectation(description: "pacakge url")
      fetcher.getPackageSwiftURL(for: url, resolvingWith: JustBranchQuery(branchName: string)).catch(only: PackageError.self) { error in
        switch error {
        case let .unsupportedHost(actual):
          XCTAssertEqual(actual, "bitbucket.com")
        default:
          XCTFail("invalid error")
        }
        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }
  }
#endif
