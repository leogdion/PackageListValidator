import XCTest

#if !canImport(ObjectiveC)
  public func allTests() -> [XCTestCaseEntry] {
    [
      testCase(PackageListValidatorTests.allTests)
    ]
  }
#endif
