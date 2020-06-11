import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class SwiftPackageDetailsTests: XCTestCase {
    func testInit() {
      let products = [Product(name: UUID().uuidString)]
      let package = Package(name: UUID().uuidString, products: products)
      let details = try? SwiftPackageDetails(package: package)
      XCTAssertEqual(details?.package.name, package.name)
      XCTAssertEqual(details?.firstProduct.name, products.first?.name)
    }

    func testError() {
      let package = Package(name: UUID().uuidString, products: [Product]())
      let error: PackageError?
      do {
        _ = try SwiftPackageDetails(package: package)
        error = nil
      } catch let caughtError as PackageError {
        error = caughtError
      } catch {
        XCTFail()
        return
      }
      switch error {
      case .some(.missingProducts):
        XCTAssert(true)
      default:
        XCTFail()
      }
    }
  }
#endif
