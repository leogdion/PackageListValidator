import Foundation

public protocol RawUrlBuilder {
  func url(basedOn specifications: RepoSpecification, forFileName fileName: String) -> URL
}
