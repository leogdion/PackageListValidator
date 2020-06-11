import Foundation

extension URL {
  static func fileRandom() -> URL {
    URL(string: FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).absoluteString.lowercased())!
  }
}
