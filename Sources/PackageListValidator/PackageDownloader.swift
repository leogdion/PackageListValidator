import Foundation
import PromiseKit

public protocol PackageDownloader {
  func download(_ packageSwiftURL: URL, withSession session: URLSession) -> Promise<URL>
}
