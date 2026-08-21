// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-single-iterator-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Single Iterator Primitives",
            targets: ["Single Iterator Primitives"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-single-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-iterator-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Single Iterator Primitives",
            dependencies: [
                .product(name: "Single Primitives", package: "swift-single-primitives"),
                .product(name: "Iterable", package: "swift-iterator-primitives"),
                .product(name: "Iterator Once Primitives", package: "swift-iterator-primitives"),
                .product(name: "Iterator Chunk Primitives", package: "swift-iterator-primitives"),
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
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
