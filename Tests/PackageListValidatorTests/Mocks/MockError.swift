import XCTest

struct MockError<Value: Equatable>: Error {
  let value: Value
}

extension MockError {
  func assertEqual(_ other: Error?) {
    guard let mockError = other as? Self else {
      XCTFail("Not a valid error types")
      return
    }

    XCTAssertEqual(mockError.value, value)
  }
}
