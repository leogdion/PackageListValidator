/**
 Simple Product structure from package dump
 */
public struct Product: Codable {
  public let name: String

  public init(name: String) {
    self.name = name
  }
}
