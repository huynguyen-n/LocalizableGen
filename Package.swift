// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalizableGen",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "LocalizableGen", targets: ["LocalizableGen"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", from: "1.5.0"),
        .package(url: "https://github.com/huynguyen-n/google-auth-library-swift", from: "0.5.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "LocalizableGen", dependencies: ["LocalizableGenCore"]),
        .target(name: "LocalizableGenCore", dependencies: ["ArgumentParser", "ColorizeSwift", "OAuth2"]),
    ]
)
