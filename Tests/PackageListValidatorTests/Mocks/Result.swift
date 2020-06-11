extension Result {
  var error: Failure? {
    switch self {
    case let .failure(error): return error
    default: return nil
    }
  }
}
