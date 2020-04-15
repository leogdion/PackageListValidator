import Foundation
import PromiseKit

public protocol TemporaryDataStorage {
  func directoryUrl(forSavingData data: Data) throws -> URL
}
