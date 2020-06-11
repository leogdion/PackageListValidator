import Foundation

/**
 Builds a URL for downloading the `Package.swift` file based on the repository specifications.
 */
public protocol RawUrlBuilder {
  /**
   Builds a URL for downloading the `Package.swift`.
   - Parameter specifications: The repository specification
   - Parameter fileName: The file name to download (i.e. `Package.swift`)
   */
  func url(basedOn specifications: RepoSpecification, forFileName fileName: String) -> URL
}
