import Foundation
import PackageListValidator

struct MockURLBuilder: RawUrlBuilder {
  let resultURL: URL
  let onURL: ((RepoSpecification, String) -> Void)?
  func url(basedOn specifications: RepoSpecification, forFileName fileName: String) -> URL {
    onURL?(specifications, fileName)
    return resultURL
  }
}
