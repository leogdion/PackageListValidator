import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class UniqueListValidatorTests: XCTestCase {
    func testinvalidUrls() {
      let validator = UniqueListValidator()
      let url = URL.fileRandom()
      let actual = validator.invalidUrls(fromUrls: [url, URL.fileRandom(), url])
      XCTAssertEqual(actual, [url])
    }
  }
#endif
