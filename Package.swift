// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "my-first-crud-using-json",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
	.package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0-rc")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "FluentSQLite"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)





