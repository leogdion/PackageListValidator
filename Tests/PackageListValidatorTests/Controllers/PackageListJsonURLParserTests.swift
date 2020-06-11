import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class PackageListJsonURLParserTests: XCTestCase {
    func testUrl() {
      let urls = (0 ... 100).map { _ in URL.fileRandom() }
      let exps = Dictionary(uniqueKeysWithValues: urls.map { ($0.appendingPathComponent("packages.json").path, expectation(description: $0.lastPathComponent)) })
      let parser = PackageListJsonURLParser { (path) -> Bool in
        exps[path]!.fulfill()
        return false
      }
      XCTAssertNil(parser.url(packagesFromDirectories: urls, andPath: nil))
      waitForExpectations(timeout: 1.0) { error in
        XCTAssertNil(error)
      }
    }

    func testUrlPath() {
      let urls = (0 ... 100).map { _ in URL.fileRandom() }
      let parser = PackageListJsonURLParser { (_) -> Bool in
        XCTFail()
        return false
      }
      let pathURL = URL.fileRandom()
      XCTAssertEqual(pathURL, parser.url(packagesFromDirectories: urls, andPath: pathURL.path))
    }
  }
#endif
