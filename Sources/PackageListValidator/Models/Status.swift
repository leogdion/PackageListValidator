import Foundation

struct Status {
  let maximumCount = 10
  let totalCount: Int
  var errorCount = 0
  var successCount = 0
  var reports = [SwiftPackageReport]()

  mutating func update(with report: SwiftPackageReport, to _: inout TextOutputStream) {
    switch report.result {
    case .failure:
      errorCount += 1
    case .success:
      successCount += 1
    }

    reports.insert(report, at: 0)

    while reports.count > 10 {
      reports = reports.dropLast(max(reports.underestimatedCount - 10, 1))
    }

    print("\u{1B}7\(errorCount)/\(successCount)/\(totalCount)\u{1B}8")
  }
}

extension FileHandle: TextOutputStream {
  public func write(_ string: String) {
    guard let data = string.data(using: .utf8) else { return }
    write(data)
  }
}
