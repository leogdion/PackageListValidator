import Foundation

public struct ReportError: Error {
  public let errors: [URL: PackageError]

  public init?(_ reports: [SwiftPackageReport]) {
    let errors = reports.compactMap { (report) -> (URL, PackageError)? in
      if case let .failure(error) = report.result {
        return (report.url, error)
      }
      return nil
    }
    if errors.count <= 0 {
      return nil
    }
    self.errors = Dictionary(uniqueKeysWithValues: errors)
  }
}
