enum Command: String {
  case all
  case diff
  case mine
}

extension Command {
  static func fromArguments(_ arguments: [String]) -> Command? {
    for argument in arguments {
      if let command = Command(rawValue: argument) {
        return command
      }
    }
    return nil
  }
}
