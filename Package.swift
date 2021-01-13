// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Playground",
    platforms: [
        .iOS(.v13)
    ],
    dependencies: [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", .exact("10.5.0"))
    ],
    targets: [
        .target(
            name: "Playground",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm")
            ]),
        .testTarget(
            name: "PlaygroundTests",
            dependencies: ["Playground"]),
    ]
)
