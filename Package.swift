// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "minimatrix-polyroots-swift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "minimatrix-polyroots-swift",
            targets: ["minimatrix-polyroots-swift"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "minimatrix-polyroots-swift"),
        .testTarget(
            name: "minimatrix-polyroots-swiftTests",
            dependencies: ["minimatrix-polyroots-swift"]),
    ]
)
