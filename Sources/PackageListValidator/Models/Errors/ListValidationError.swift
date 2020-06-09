public struct ListValidationError: Error {
  let errors: [ListValidationChildError]

  init?(errors: [ListValidationChildError]) {
    guard errors.count > 0 else {
      return nil
    }
    self.errors = errors
  }
}
