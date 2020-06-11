import Foundation
import XCTest

class MockPipe: Pipe {
  let value = UUID()
  func assertEquals(_ pipe: Any?) {
    XCTAssertEqual(value, (pipe as? MockPipe)?.value)
  }
}
