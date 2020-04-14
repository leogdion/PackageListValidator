import Foundation
import PromiseKit

protocol GitHostResolver {
  func packageUrl(for gitUrl: URL) -> Promise<URL>
}
