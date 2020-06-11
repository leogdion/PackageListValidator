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

  extension GitHubResolverTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GitHubResolverTests = [
      ("testPackageURL", testPackageURL)
    ]
  }

  extension ListFetcherTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ListFetcherTests = [
      ("testListWithSession", testListWithSession)
    ]
  }

  extension PackageListJsonURLParserTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PackageListJsonURLParserTests = [
      ("testUrl", testUrl),
      ("testUrlPath", testUrlPath)
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

  extension PackageUrlFetcherTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PackageUrlFetcherTests = [
      ("testGetPackageInvalidHost", testGetPackageInvalidHost),
      ("testGetPackageNoHost", testGetPackageNoHost)
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

  extension TemporaryPackageDownloaderTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TemporaryPackageDownloaderTests = [
      ("testDownload", testDownload)
    ]
  }

  extension UniqueListValidatorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__UniqueListValidatorTests = [
      ("testinvalidUrls", testinvalidUrls)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    [
      testCase(GitHubDefaultBranchQueryTests.__allTests__GitHubDefaultBranchQueryTests),
      testCase(GitHubRawUrlBuilderTests.__allTests__GitHubRawUrlBuilderTests),
      testCase(GitHubResolverTests.__allTests__GitHubResolverTests),
      testCase(ListFetcherTests.__allTests__ListFetcherTests),
      testCase(PackageListJsonURLParserTests.__allTests__PackageListJsonURLParserTests),
      testCase(PackageListValidatorTests.__allTests__PackageListValidatorTests),
      testCase(PackageUrlFetcherTests.__allTests__PackageUrlFetcherTests),
      testCase(ReportErrorTests.__allTests__ReportErrorTests),
      testCase(SortedListValidatorTests.__allTests__SortedListValidatorTests),
      testCase(SwiftPackageDetailsTests.__allTests__SwiftPackageDetailsTests),
      testCase(TemporaryPackageDownloaderTests.__allTests__TemporaryPackageDownloaderTests),
      testCase(UniqueListValidatorTests.__allTests__UniqueListValidatorTests)
    ]
  }
#endif
