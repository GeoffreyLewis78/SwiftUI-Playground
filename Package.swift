// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIPlayground",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SwiftUIPlayground",
            targets: ["SwiftUIPlayground"]),
    ],
    targets: [
        .target(
            name: "SwiftUIPlayground",
            dependencies: []),
        .testTarget(
            name: "SwiftUIPlaygroundTests",
            dependencies: ["SwiftUIPlayground"],
            resources: [
                .copy("Resources")
            ]),
    ]
)
