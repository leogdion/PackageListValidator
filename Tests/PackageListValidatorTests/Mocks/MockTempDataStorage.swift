import Foundation
import PackageListValidator

struct MockTempDataStorage: TemporaryDataStorage {
  let resultURL: URL
  func directoryUrl(forSavingData _: Data) throws -> URL {
    resultURL
  }
}
