import Foundation
import PromiseKit

/**
 Based on the URL, resolves the URL to download the `Package.swift`.
 */
public protocol GitHostResolver {
  /**
   Returns a Promise of the downloadable URL for the `Package.swift` file.
   - Parameter gitUrl: The URL to the git repository.
   - Returns: A Promise of the URL
   */
  func packageUrl(for gitUrl: URL) -> Promise<URL>
}
