/**
 Simple Package structure from package dump
 */
public struct Package: Codable {
  public let name: String
  public let products: [Product]

  public init(name: String, products: [Product]) {
    self.name = name
    self.products = products
  }
}
