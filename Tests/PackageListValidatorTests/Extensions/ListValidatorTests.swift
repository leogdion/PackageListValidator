import PackageListValidator
#if !os(watchOS)
  import XCTest
  struct MockListValidator: ListValidator {
    let result: [URL]
    static let errorDescription: String = UUID().uuidString
    static let successDescription: String = UUID().uuidString
    func invalidUrls(fromUrls _: [URL]) -> [URL] {
      result
    }
  }

  final class ListValidatorTests: XCTestCase {
    func testValidateUrls() {
      let expected = (0 ... 99).map { _ in URL.fileRandom() }
      let validator = MockListValidator(result: expected)
      let actual = validator.validateUrls((0 ... 99).map { _ in URL.fileRandom() })
      XCTAssertEqual(actual?.urls, expected)
      XCTAssertEqual(actual?.description, MockListValidator.errorDescription)
    }
  }
#endif
