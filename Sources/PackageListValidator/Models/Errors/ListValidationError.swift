public struct ListValidationError: Error {
  public let errors: [ListValidationChildError]

  public init?(errors: [ListValidationChildError]) {
    guard errors.count > 0 else {
      return nil
    }
    self.errors = errors
  }
}
