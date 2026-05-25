// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-single-iterator-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Single Iterator Primitives",
            targets: ["Single Iterator Primitives"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-single-primitives"),
        .package(path: "../swift-iterator-primitives"),
    ],
    targets: [
        .target(
            name: "Single Iterator Primitives",
            dependencies: [
                .product(name: "Single Primitives", package: "swift-single-primitives"),
                .product(name: "Iterable", package: "swift-iterator-primitives"),
                .product(name: "Once Primitives", package: "swift-iterator-primitives"),
            ]
        ),
        .testTarget(
            name: "Single Iterator Primitives Tests",
            dependencies: ["Single Iterator Primitives"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
