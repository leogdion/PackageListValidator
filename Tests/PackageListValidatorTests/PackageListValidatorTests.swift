@testable import PackageListValidator
import XCTest

final class PackageListValidatorTests: XCTestCase {
  func testExample() {
    do {
      _ = try PackageListValidator.parseAsRoot(["mine"])
    } catch {
      XCTAssertNil(error)
    }

    do {
      _ = try PackageListValidator.parseAsRoot(["all"])
    } catch {
      XCTAssertNil(error)
    }

    do {
      _ = try PackageListValidator.parseAsRoot(["diff"])
    } catch {
      XCTAssertNil(error)
    }

    let error: Error?
    do {
      _ = try PackageListValidator.parseAsRoot([UUID().uuidString])
      error = nil
    } catch let caughtError {
      error = caughtError
    }
    XCTAssertNotNil(error)
  }
}
