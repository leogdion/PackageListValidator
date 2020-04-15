import Foundation

public struct SwiftPackageReport {
  let url: URL
  let result: Result<SwiftPackageDetails, PackageError>
}
