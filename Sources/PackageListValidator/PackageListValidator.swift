import ArgumentParser
import Foundation
import PromiseKit

public struct PackageListValidator: ParsableCommand {
  public static var configuration = CommandConfiguration(
    subcommands: [All.self, Mine.self, Diff.self])
  public init() {}
}
