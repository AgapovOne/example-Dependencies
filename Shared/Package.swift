// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SharedDependencies",
            targets: ["SharedDependencies"]),
        .library(
            name: "FeatureSettings",
            targets: ["FeatureSettings"]),
        .library(
            name: "FeatureMainScreen",
            targets: ["FeatureMainScreen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay.git", from: "1.1.1"),
        .package(url: "https://github.com/pointfreeco/swift-concurrency-extras.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "SharedDependencies",
            dependencies: [
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),

        .target(
            name: "FeatureSettings",
            dependencies: [.target(name: "SharedDependencies")]
        ),

        .target(
            name: "FeatureMainScreen",
            dependencies: [
                .target(name: "SharedDependencies"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
                .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras")
            ]
        ),
        .testTarget(
            name: "FeatureMainScreenTests",
            dependencies: ["FeatureMainScreen"]
        ),
    ]
)
