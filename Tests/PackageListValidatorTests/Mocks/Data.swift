import Foundation

extension Data {
  static func random() -> Data {
    let array = (1 ... 255).map { _ in UInt8.random(in: 0 ... 255) }
    return Data(array)
  }
}
