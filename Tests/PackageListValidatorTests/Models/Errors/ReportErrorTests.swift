import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class ReportErrorTests: XCTestCase {
    func testInit() {
      let goodUrl = URL.fileRandom()
      let badUrl = URL.fileRandom()
      let error = PackageError.dumpTimeout
      let goodDetails: SwiftPackageDetails
      do {
        goodDetails = try SwiftPackageDetails(
          package: Package(
            name: UUID().uuidString,
            products: [Product(name: UUID().uuidString)]
          ))
      } catch {
        XCTAssertNil(error)
        return
      }
      let reports = [
        SwiftPackageReport(
          url: goodUrl,
          result: .success(goodDetails)
        ),
        SwiftPackageReport(url: badUrl, result: .failure(error))
      ]
      let report = ReportError(reports)
      switch report?.errors[badUrl] {
      case .some(.dumpTimeout):
        XCTAssert(true)
      default:
        XCTFail("Invalid Error")
      }
      XCTAssertNil(report?.errors[goodUrl])
    }
  }
#endif
