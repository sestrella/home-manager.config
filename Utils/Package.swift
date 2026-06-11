// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utils",
    dependencies: [
        .package(
            url: "https://github.com/waydabber/AppleSiliconDDC.git",
            revision: "97af3818b9803e51412fb50cac1506db1d73b5bf"),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Utils",
            dependencies: [
                .product(name: "AppleSiliconDDC", package: "AppleSiliconDDC"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
