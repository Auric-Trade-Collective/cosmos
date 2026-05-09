// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Cosmos",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .macCatalyst(.v13)],
    dependencies: [
        .package(
            url: "https://github.com/moreSwift/swift-cross-ui",
            .upToNextMinor(from: "0.5.1")
        ),
        .package(path: "../CosmosModels"),
    ],
    targets: [
        .executableTarget(
            name: "Cosmos",
            dependencies: [
                .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
                .product(name: "DefaultBackend", package: "swift-cross-ui"),
                "CosmosModels",
            ]
        )
    ]
)
