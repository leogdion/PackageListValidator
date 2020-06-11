import PackageListValidator
#if !os(watchOS)
  import PromiseKit
  import XCTest
  struct MockURLFetcher: PackageUrlFetcherProtocol {
    let resultURL: URL
    let onBranch: ((String) -> Void)?
    func getPackageSwiftURL(for _: URL, resolvingWith branchQuery: DefaultBranchQuery) -> Promise<URL> {
      branchQuery.defaultBranchName(forRepoName: UUID().uuidString, withOwner: UUID().uuidString).map { branchName in
        self.onBranch?(branchName)
        return self.resultURL
      }
    }
  }

  struct MockTempDataStorage: TemporaryDataStorage {
    let resultURL: URL
    func directoryUrl(forSavingData _: Data) throws -> URL {
      resultURL
    }
  }

  final class TemporaryPackageDownloaderTests: XCTestCase {
    func testDownload() {
      let branch = UUID().uuidString
      let fetchedURL = URL.fileRandom()
      let storageURL = URL.fileRandom()
      let sourceURL = URL.fileRandom()
      let resultURL = URL.fileRandom()
      let expSession = expectation(description: "session")
      let mockSession = MockSession(result: .success(resultURL)) {
        XCTAssertEqual(fetchedURL, $0)
        expSession.fulfill()
      }
      let expFetcher = expectation(description: "fetcher")
      let mockFetcher = MockURLFetcher(resultURL: fetchedURL) {
        XCTAssertEqual(branch, $0)
        expFetcher.fulfill()
      }
      let mockStorage = MockTempDataStorage(resultURL: storageURL)
      let downloader = TemporaryPackageDownloader(branchQuery: JustBranchQuery(branchName: branch), urlFetcher: mockFetcher, tempDataStorage: mockStorage, delay: 0.0)
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
      // downloader.download(<#T##packageSwiftURL: URL##URL#>, withSession: <#T##Session#>)
    }
  }
#endif
