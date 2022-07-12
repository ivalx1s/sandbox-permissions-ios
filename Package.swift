// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "sandbox-permissions-ios",
    products: [
        .library(
            name: "SandboxPermissions",
            targets: ["SandboxPermissions"]),
    ],
    targets: [
        .target(
            name: "SandboxPermissions",
            path: "Sources"
        ),
    ]
)
