// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyFrame",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "SwiftyFrame",
            targets: ["SwiftyFrame"])
    ],
    targets: [
        .target(
            name: "SwiftyFrame",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "SwiftyFrameTests",
            dependencies: ["SwiftyFrame"],
            path: "Tests"),
    ]
)
