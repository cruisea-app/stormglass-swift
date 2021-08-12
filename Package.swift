// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StormGlass",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(name: "StormGlass", targets: ["StormGlass"]),
    ],
    targets: [
        .target(
            name: "StormGlass",
            dependencies: []
        ),
        .testTarget(
            name: "StormGlassTests",
            dependencies: ["StormGlass"]
        ),
    ]
)
