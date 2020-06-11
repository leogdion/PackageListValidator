import PackageListValidator
#if !os(watchOS)
  import XCTest

  final class SortedListValidatorTests: XCTestCase {
    func testSort() {
      let sorter = SortedListValidator()
      let unSortedURLs = (0 ... 100).map { _ in URL.fileRandom() }

      let sortedList = unSortedURLs.sorted {
        $0.absoluteString.lowercased() < $1.absoluteString.lowercased()
      }

      let newSortedList = sorter.invalidUrls(fromUrls: sortedList)

      XCTAssert(newSortedList.isEmpty)
    }
  }
#endif
