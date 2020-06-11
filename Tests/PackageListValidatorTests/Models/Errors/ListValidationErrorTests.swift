import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class ListValidationErrorTests: XCTestCase {
    func testInit() {
      let url = URL.fileRandom()
      let description = UUID().uuidString
      let childError = ListValidationChildError(description: description, urls: [url])
      let error = ListValidationError(errors: [childError].compactMap { $0 })
      XCTAssertEqual(error?.errors.first?.urls.first, url)
      XCTAssertEqual(error?.errors.first?.description, description)
    }

    func testEmpty() {
      let error = ListValidationError(errors: [])
      XCTAssertNil(error)
    }
  }
#endif
