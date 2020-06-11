import XCTest

struct MockError<Value: Equatable>: Error {
  let value: Value
}

extension MockError {
  func assertEqual(_ other: Error?) {
    guard let mockError = other as? Self else {
      XCTFail("")
      return
    }

    XCTAssertEqual(mockError.value, value)
  }
}
