import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class GitUrlListValidatorTests: XCTestCase {
    func testInvalidUrls() {
      let validator = GitUrlListValidator()
      let badUrls = (0 ... 99).map { _ in URL.fileRandom() }
      let goodUrls = badUrls.map { $0.appendingPathExtension("git") }
      let allUrls = (badUrls + goodUrls).shuffled()
      let actual = validator.invalidUrls(fromUrls: allUrls)

      XCTAssertEqual(Set(actual), Set(badUrls))
    }
  }
#endif
