import Foundation
import PromiseKit

public protocol GitHostResolver {
  func packageUrl(for gitUrl: URL) -> Promise<URL>
}
