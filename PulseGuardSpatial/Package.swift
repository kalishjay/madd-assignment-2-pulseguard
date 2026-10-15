// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PulseGuardSpatial",
    platforms: [
        .visionOS(.v1),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "PulseGuardSpatial",
            targets: ["PulseGuardSpatial"]
        ),
    ],
    targets: [
        .target(
            name: "PulseGuardSpatial",
            path: "PulseGuardSpatial"
        ),
    ]
)
