// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "transition-diagram-dragon-book",
    products: [
        .executable(
            name: "transition-diagram-dragon-book",
            targets: ["transition-diagram-dragon-book"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "transition-diagram-dragon-book",
            dependencies: ["lexer"]),
        .target(
            name: "lexer",
            dependencies: []),
        .testTarget(
            name: "lexerTests",
            dependencies: ["lexer"]),
    ]
)
