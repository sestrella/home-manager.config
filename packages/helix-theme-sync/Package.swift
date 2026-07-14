// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "helix-theme-sync",
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", "1.0.0"..<"1.7.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "helix-theme-sync",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
