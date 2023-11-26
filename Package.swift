// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC2021",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "AOC2021",
            dependencies: [
                "AOC2021Core",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .target(
            name: "AOC2021Core",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms")
            ],
            resources: [
                .process("Inputs")
            ]
        ),
        .testTarget(
            name: "AOC2021Tests",
            dependencies: ["AOC2021"]),
        .testTarget(
            name: "AOC2021CoreTests",
            dependencies: ["AOC2021Core"]),
    ]
)
