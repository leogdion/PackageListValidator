import ArgumentParser
import Foundation
import PromiseKit

public struct PackageListValidator: ParsableCommand {
  public static var configuration = CommandConfiguration(
    commandName: "swiftpmls",
    subcommands: [All.self, Mine.self, Diff.self]
  )
  public init() {}
}
