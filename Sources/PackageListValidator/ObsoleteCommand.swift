@available(*, deprecated)
enum ObsoleteCommand: String {
  case all
  case diff
  case mine
}

extension ObsoleteCommand {
  @available(*, deprecated)
  static func fromArguments(_ arguments: [String]) -> ObsoleteCommand? {
    for argument in arguments {
      if let command = ObsoleteCommand(rawValue: argument) {
        return command
      }
    }
    return nil
  }
}
