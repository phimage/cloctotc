// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cloctotc",
    products: [
        .executable(
            name: "cloctotc", targets: ["cloctotc"]
        )
    ],
    targets: [
        .target(
            name: "cloctotc",
            path: "Sources"
        )
    ]
)
