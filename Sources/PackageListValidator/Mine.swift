import ArgumentParser

public struct Mine: ParsableCommand {
  @Argument(default: "Current Directory")
  var path: String?

  public init() {}
}
