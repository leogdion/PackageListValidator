import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class PackageUrlFetcherTests: XCTestCase {}
#endif