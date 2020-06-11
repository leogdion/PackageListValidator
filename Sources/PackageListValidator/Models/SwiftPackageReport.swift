import Foundation

public struct SwiftPackageReport {
  public let url: URL
  public let result: Result<SwiftPackageDetails, PackageError>
  public init(url: URL, result: Result<SwiftPackageDetails, PackageError>) {
    self.url = url
    self.result = result
  }
}
