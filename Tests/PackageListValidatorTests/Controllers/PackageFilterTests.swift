import PackageListValidator
#if !os(watchOS)
  import XCTest
  struct MockListFetcher: ListFetcherProtocol {
    let result: Result<[URL], Error>
    func listWithSession<SessionType>(_: SessionType, usingDecoder _: JSONDecoder, _ completed: @escaping (Result<[URL], Error>) -> Void) where SessionType: Session {
      completed(result)
    }
  }

  final class PackageFilterTests: XCTestCase {
    func testFilter() {
      let expected = (0 ... 49).map { _ in URL.fileRandom() }
      let removing = (0 ... 49).map { _ in URL.fileRandom() }

      let fetcher = MockListFetcher(result: .success(removing))
      let filter = PackageFilter(type: .diffWith(fetcher))
      let exp = expectation(description: "filtered")
      filter.filterRepos((expected + removing).shuffled(), withSession: MockSession<UUID>(result: nil, onURL: nil), usingDecoder: JSONDecoder()) { result in
        let actual = (try? result.get()).map { Set($0) }
        XCTAssertEqual(Set(expected), actual)
        exp.fulfill()
      }
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }
  }
#endif
