import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class ListValidationChildErrorTests: XCTestCase {
    func testEmpty() {
      let description = UUID().uuidString
      let childError = ListValidationChildError(description: description, urls: [])
      XCTAssertNil(childError)
    }
  }
#endif
