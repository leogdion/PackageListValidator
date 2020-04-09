extension Result where Success == Void {
  init(_ error: Failure?) {
    if let error = error {
      self = .failure(error)
    } else {
      self = .success(Void())
    }
  }
}
