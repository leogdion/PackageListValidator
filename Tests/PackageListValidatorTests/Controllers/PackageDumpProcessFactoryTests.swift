import PackageListValidator
#if !os(watchOS)
  import XCTest

  final class PackageDumpProcessFactoryTests: XCTestCase {
    func testDumpPackageProcessAt() {
      let factory = PackageDumpProcessFactory()
      let url = URL.fileRandom()
      let output = MockPipe()
      let errorPipe = MockPipe()
      let process = factory.dumpPackageProcessAt(url, outputTo: output, errorsTo: errorPipe)
      if #available(OSX 10.13, *) {
        XCTAssertEqual(process.executableURL, URL(fileURLWithPath: "/usr/bin/swift"))
      } else {
        XCTAssertEqual(process.launchPath, "/usr/bin/swift")
      }
      XCTAssertEqual(process.arguments, ["package", "dump-package"])
      output.assertEquals(process.standardOutput)
      errorPipe.assertEquals(process.standardError)
    }
  }
#endif
