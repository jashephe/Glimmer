// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Glimmer",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Glimmer", targets: ["Glimmer"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "Glimmer", dependencies: [])
    ]
)
