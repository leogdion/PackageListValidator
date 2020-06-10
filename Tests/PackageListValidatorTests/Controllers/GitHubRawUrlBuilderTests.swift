import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class GitHubRawUrlBuilderTests: XCTestCase {
    func test() {
      var components = URLComponents()
      components.host = UUID().uuidString
      components.scheme = "http"
      let fileName = UUID().uuidString
      let specs = RepoSpecification(repositoryName: UUID().uuidString, userName: UUID().uuidString, branchName: UUID().uuidString)
      let builder = GitHubRawUrlBuilder(rawURLComponentsBase: components)

      let url = builder.url(basedOn: specs, forFileName: fileName)
      guard let actual = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
        XCTFail()
        return
      }
      let pathComponents = actual.path.components(separatedBy: "/")
      XCTAssertEqual(pathComponents.count, 5)
      XCTAssertEqual(pathComponents[1], specs.userName)
      XCTAssertEqual(pathComponents[2], specs.repositoryName)
      XCTAssertEqual(pathComponents[3], specs.branchName)
      XCTAssertEqual(pathComponents[4], fileName)
      XCTAssertEqual(actual.scheme, components.scheme)
      XCTAssertEqual(actual.host, components.host)
    }
  }
#endif
