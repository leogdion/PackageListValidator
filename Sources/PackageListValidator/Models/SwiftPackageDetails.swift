struct SwiftPackageDetails {
  let firstProduct: Product
  let package: Package

  init(package: Package) throws {
    guard let firstProduct = package.products.first else {
      throw PackageError.missingProducts
    }
    self.firstProduct = firstProduct
    self.package = package
  }
}
