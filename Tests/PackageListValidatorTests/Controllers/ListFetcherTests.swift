import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class ListFetcherTests: XCTestCase {
    func testListWithSession() {
      let url = URL.fileRandom()
      let fetcher = ListFetcher(listURL: url)
      let list = (1 ... 100).map { _ in URL.fileRandom() }
      let expSession = expectation(description: "session")
      let mockSession = MockSession(result: .success(list)) { actual in
        XCTAssertEqual(actual, url)
        expSession.fulfill()
      }
      let expList = expectation(description: "list")
      let decoder = JSONDecoder()
      fetcher.listWithSession(mockSession, usingDecoder: decoder) { result in
        let actual = try? result.get()
        XCTAssertEqual(actual, list)
        expList.fulfill()
      }

      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }
  }
#endif
