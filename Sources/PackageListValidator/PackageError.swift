import Foundation

/**
 List of possible errors for each package
 */
enum PackageError: Error {
  case noResult
  case invalidURL(URL)
  case unsupportedHost(String)
  case readError(Error?)
  case badDump(String?)
  case decodingError(Error)
  case missingProducts
  case dumpTimeout

  var friendlyName: String {
    switch self {
    case .noResult:
      return "No Result"
    case .invalidURL:
      return "Invalid URL"
    case .unsupportedHost:
      return "Unsupported Host"
    case .readError:
      return "Download Failure"
    case .badDump:
      return "Invalid Dump"
    case .decodingError:
      return "Dump Decoding Error"
    case .missingProducts:
      return "No Products"
    case .dumpTimeout:
      return "Dump Timeout"
    }
  }
}
