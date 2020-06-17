import ArgumentParser
import Foundation
import PromiseKit

public struct Validate: ParsableCommand {
  public static var configuration = CommandConfiguration(
    subcommands: [All.self, Mine.self, Diff.self]
  )
  public init() {}
}
