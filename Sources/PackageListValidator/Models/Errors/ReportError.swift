import Foundation

struct ReportError: Error {
  let errors: [URL: PackageError]

  init?(_ reports: [SwiftPackageReport]) {
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
