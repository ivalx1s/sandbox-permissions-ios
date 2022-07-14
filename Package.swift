// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "sandbox-permissions-ios",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "SandboxPermissions",
            targets: ["SandboxPermissions"]),
    ],
    targets: [
        .target(
            name: "SandboxPermissions",
            path: "Sources",
            resources: [.process("Resources")]
        ),
    ]
)
