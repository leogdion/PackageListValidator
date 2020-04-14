import Foundation
import PromiseKit

protocol PackageParser {
  func verifyPackageDump(at directoryURL: URL, withDecoder decoder: JSONDecoder) -> Promise<SwiftPackageDetails>
}
