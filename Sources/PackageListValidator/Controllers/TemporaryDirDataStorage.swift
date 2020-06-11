import Foundation

public struct TemporaryDirDataStorage: TemporaryDataStorage {
  public init() {}

  public func directoryUrl(forSavingData data: Data) throws -> URL {
    let temporaryDirectoryURL: URL
    temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
    let outputDirURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: outputDirURL, withIntermediateDirectories: false, attributes: nil)
    try data.write(to: outputDirURL.appendingPathComponent("Package.swift"), options: .atomic)
    return outputDirURL
  }
}
