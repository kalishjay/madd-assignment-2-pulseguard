// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PulseGuardAI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "PulseGuardAI",
            targets: ["PulseGuardAI"]
        ),
    ],
    targets: [
        .target(
            name: "PulseGuardAI",
            path: "PulseGuardAI"
        ),
        .testTarget(
            name: "PulseGuardAITests",
            dependencies: ["PulseGuardAI"],
            path: "PulseGuardAITests"
        ),
    ]
)
