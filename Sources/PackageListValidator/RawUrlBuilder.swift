import Foundation

public protocol RawUrlBuilder {
  func url(basedOn specifications: RepoSpecification) -> URL
}
