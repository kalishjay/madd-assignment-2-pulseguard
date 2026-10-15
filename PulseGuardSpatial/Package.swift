// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PulseGuardSpatial",
    platforms: [
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "PulseGuardSpatialCore",
            targets: ["PulseGuardSpatialCore"]
        ),
    ],
    targets: [
        .target(
            name: "PulseGuardSpatialCore",
            path: "PulseGuardSpatial"
        ),
    ]
)
