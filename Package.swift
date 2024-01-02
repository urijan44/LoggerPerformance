// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoggerPerformance",
    products: [
        .executable(
            name: "LoggerPerformance",
            targets: ["LoggerPerformance"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.3.0")
    ],
    targets: [
      .executableTarget(
        name: "LoggerPerformance",
        dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ],
        path: "./",
        resources: [
          .copy("bundle.json")
        ]
      )
      
    ]
)
