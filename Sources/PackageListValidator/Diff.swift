import ArgumentParser

public struct Diff: ParsableCommand {
  @Argument(default: "packages.json")
  var path: String?

  public init() {}
}
