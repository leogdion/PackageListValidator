import Foundation
public struct Configuration {
  public static let `default` = Configuration()

  public let semaphoreCount = 3
  public let timeoutIntervalForRequest = 3000.0
  public let timeoutIntervalForResource = 6000.0

  // base url for github raw files
  public let rawURLComponentsBase = URLComponents(string: "https://raw.githubusercontent.com")!

  public let masterPackageGitHubPath = "daveverwer/SwiftPMLibrary/master/packages.json"
  // master package list to compare against
  public var masterPackageList: URL? {
    rawURLComponentsBase.url?.appendingPathComponent(masterPackageGitHubPath)
  }

  public let logEveryCount = 10
  public let httpMaximumConnectionsPerHost = 10
  public let displayProgress = false
  public let processTimeout = 50.0

  public var config: URLSessionConfiguration {
    let config: URLSessionConfiguration = .default
    config.timeoutIntervalForRequest = timeoutIntervalForRequest
    config.timeoutIntervalForResource = timeoutIntervalForResource
    config.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
    return config
  }

  private init() {}
}
