// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PackageListValidator",
  platforms: [
    .macOS(.v10_12)
  ],
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "PackageListValidator",
      targets: ["PackageListValidator"]
    ),
    .executable(
      name: "swiftpmls",
      targets: ["swiftpmls"]
    )
  ],
  dependencies: [
    // User deps
    .package(url: "https://github.com/mxcl/PromiseKit.git", from: "7.0.0-alpha.3"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.0.4"),

    // Dev deps
    .package(url: "https://github.com/shibapm/Komondor", from: "1.0.5"), // dev
    .package(url: "https://github.com/eneko/SourceDocs", from: "1.0.0"), // dev
    .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.41.2"), // dev
    .package(url: "https://github.com/f-meloni/Rocket", from: "0.1.0"), // dev
    .package(url: "https://github.com/Realm/SwiftLint.git", from: "0.39.2") // dev
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "PackageListValidator",
      dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"), "PromiseKit"]
    ),
    .target(
      name: "swiftpmls",
      dependencies: ["PackageListValidator"]
    ),
    .testTarget(
      name: "PackageListValidatorTests",
      dependencies: ["PackageListValidator"]
    )
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let config = PackageConfiguration([
    "komondor": [
      "pre-push": "swift test --enable-code-coverage --enable-test-discovery",
      "pre-commit": [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "swift run sourcedocs generate --spm-module PackageListValidator -r",
        "swift run swiftpmls mine",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
