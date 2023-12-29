// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoggerPerformance",
    platforms: [.iOS(.v14), .macOS(.v12)],
    products: [
        .executable(
            name: "LoggerPerformance",
            targets: ["LoggerPerformance"]),
    ],
    
    targets: [
      .executableTarget(
        name: "LoggerPerformance",
        path: "./",
        resources: [
          .copy("bundle.json")
        ]
      )
      
    ]
)
