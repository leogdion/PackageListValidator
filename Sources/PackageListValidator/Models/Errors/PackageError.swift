import Foundation

/**
 List of possible errors for each package
 */
public enum PackageError: Error {
  /**
   No Result Returned From Any Call
   */
  case noResult
  /**
    The URL listed is invalid for a repository.
   */
  case invalidURL(URL)
  /**
    The git host is not supported.
   */
  case unsupportedHost(String)
  /**
    SPM cannot decipher the `Package.swift` file.
   */
  case badDump(String?)
  /**
    Could not decode the result the pacakge dump.
   */
  case decodingError(Error)
  /**
   No product listed.
   */
  case missingProducts
  /**
   The `dump-package` process timed out.
   */
  case dumpTimeout

  public var friendlyName: String {
    switch self {
    case .noResult:
      return "No Result"
    case .invalidURL:
      return "Invalid URL"
    case .unsupportedHost:
      return "Unsupported Host"
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
