import PackageListValidator
#if !os(watchOS)
  import PromiseKit
  import XCTest

  final class TemporaryPackageDownloaderTests: XCTestCase {
    func testDownload() {
      let branch = UUID().uuidString
      let fetchedURL = URL.fileRandom()
      let storageURL = URL.fileRandom()
      let sourceURL = URL.fileRandom()
      let resultURL = URL.fileRandom()
      let expSession = expectation(description: "session")
      let mockSession = MockSession(result: .success([resultURL])) {
        XCTAssertEqual(fetchedURL, $0)
        expSession.fulfill()
      }
      let expFetcher = expectation(description: "fetcher")
      let mockFetcher = MockURLFetcher(resultURL: fetchedURL) {
        XCTAssertEqual(branch, $0)
        expFetcher.fulfill()
      }
      let mockStorage = MockTempDataStorage(resultURL: storageURL)
      let downloader = TemporaryPackageDownloader(
        branchQuery: JustBranchQuery(branchName: branch),
        urlFetcher: mockFetcher,
        tempDataStorage: mockStorage, delay: 0.0
      )
      let expDownload = expectation(description: "download")
      downloader.download(sourceURL, withSession: mockSession).done {
        XCTAssertEqual($0, storageURL)
        expDownload.fulfill()
      }.catch {
        XCTAssertNil($0)
        expDownload.fulfill()
      }

      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }
  }
#endif
