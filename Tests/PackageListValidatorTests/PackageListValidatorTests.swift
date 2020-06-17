@testable import PackageListValidator
import XCTest

final class PackageListValidatorTests: XCTestCase {
  func testExample() {
    do {
      _ = try Validate.parseAsRoot(["mine"])
    } catch {
      XCTAssertNil(error)
    }

    do {
      _ = try Validate.parseAsRoot(["all"])
    } catch {
      XCTAssertNil(error)
    }

    do {
      _ = try Validate.parseAsRoot(["diff"])
    } catch {
      XCTAssertNil(error)
    }

    let error: Error?
    do {
      _ = try Validate.parseAsRoot([UUID().uuidString])
      error = nil
    } catch let caughtError {
      error = caughtError
    }
    XCTAssertNotNil(error)
  }
}
