#if !canImport(ObjectiveC)
  import XCTest

  extension GitHubDefaultBranchQueryTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GitHubDefaultBranchQueryTests = [
      ("testDefault", testDefault),
      ("testDefaultBranchName", testDefaultBranchName),
      ("testEmpty", testEmpty),
      ("testMaster", testMaster),
      ("testPassedError", testPassedError)
    ]
  }

  extension GitHubRawUrlBuilderTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GitHubRawUrlBuilderTests = [
      ("test", test)
    ]
  }

  extension PackageListValidatorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PackageListValidatorTests = [
      ("testExample", testExample)
    ]
  }

  extension ReportErrorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ReportErrorTests = [
      ("testInit", testInit)
    ]
  }

  extension SortedListValidatorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SortedListValidatorTests = [
      ("testSort", testSort)
    ]
  }

  extension SwiftPackageDetailsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftPackageDetailsTests = [
      ("testError", testError),
      ("testInit", testInit)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    [
      testCase(GitHubDefaultBranchQueryTests.__allTests__GitHubDefaultBranchQueryTests),
      testCase(GitHubRawUrlBuilderTests.__allTests__GitHubRawUrlBuilderTests),
      testCase(PackageListValidatorTests.__allTests__PackageListValidatorTests),
      testCase(ReportErrorTests.__allTests__ReportErrorTests),
      testCase(SortedListValidatorTests.__allTests__SortedListValidatorTests),
      testCase(SwiftPackageDetailsTests.__allTests__SwiftPackageDetailsTests)
    ]
  }
#endif
