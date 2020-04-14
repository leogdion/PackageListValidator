public struct ListValidatorKey: Identifiable, Hashable {
  public static func == (lhs: ListValidatorKey, rhs: ListValidatorKey) -> Bool {
    lhs.id == rhs.id
  }

  public let id: String
  public let validator: ListValidator

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
