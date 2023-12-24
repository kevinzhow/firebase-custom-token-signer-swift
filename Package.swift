// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseCustomTokenSigner",
    platforms:  [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "FirebaseCustomTokenSigner",
            targets: ["FirebaseCustomTokenSigner"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "FirebaseCustomTokenSigner",
             dependencies: [
                .product(name: "JWTKit", package: "jwt-kit"),
            ]
        ),
        .testTarget(
            name: "FirebaseCustomTokenSignerTests",
            dependencies: ["FirebaseCustomTokenSigner"],
            resources: [
                .copy("Resources/test.json"),
            ]),
    ]
)
