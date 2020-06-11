import Foundation

extension URL {
  static func fileRandom() -> URL {
    FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
  }
}
