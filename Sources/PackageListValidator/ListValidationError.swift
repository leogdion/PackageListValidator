public struct ListValidationError: Error {
  let errors: [ValidationError]

  init?(errors: [ValidationError]) {
    guard errors.count > 0 else {
      return nil
    }
    self.errors = errors
  }
}
