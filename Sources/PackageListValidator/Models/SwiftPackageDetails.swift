public struct SwiftPackageDetails {
  public let firstProduct: Product
  public let package: Package

  public init(package: Package) throws {
    guard let firstProduct = package.products.first else {
      throw PackageError.missingProducts
    }
    self.firstProduct = firstProduct
    self.package = package
  }
}
