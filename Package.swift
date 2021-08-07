// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MaeRuntime",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "MaeABI", targets: ["MaeABI"]),
        .library(name: "MaeAssembler", targets: ["MaeAssembler"]),
        .executable(name: "masm", targets: ["MaeAssembler"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-collections",
            .exact("0.0.3")
            )
    ],
    targets: [
        .target(
            name: "MaeABI",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ]),
        .target(
            name: "MaeAssembler",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
                "MaeABI"
            ]
        ),
        .testTarget(
            name: "MaeABITests",
            dependencies: ["MaeABI"]),
        .testTarget(
            name: "MaeAssemblerTests",
            dependencies: ["MaeAssembler"]),
    ]
)
