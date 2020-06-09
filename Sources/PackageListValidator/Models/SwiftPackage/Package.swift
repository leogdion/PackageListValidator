/**
 Simple Package structure from package dump
 */
struct Package: Codable {
  let name: String
  let products: [Product]
}
