import Foundation

public struct TemporaryDirDataStorage: TemporaryDataStorage {
  public let temporaryDirectoryURL: () -> (URL)
  public init(temporaryDirectoryURL: (() -> (URL))? = nil) {
    self.temporaryDirectoryURL = temporaryDirectoryURL ?? {
      FileManager.default.temporaryDirectory
    }
  }

  public func directoryUrl(forSavingData data: Data) throws -> URL {
    let temporaryDirectoryURL: URL
    temporaryDirectoryURL = self.temporaryDirectoryURL()
    let outputDirURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: outputDirURL, withIntermediateDirectories: false, attributes: nil)
    try data.write(to: outputDirURL.appendingPathComponent("Package.swift"), options: .atomic)
    return outputDirURL
  }
}
