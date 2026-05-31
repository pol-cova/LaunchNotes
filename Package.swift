// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "LaunchNotes",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
    ],
    products: [
        .library(
            name: "LaunchNotes",
            targets: ["LaunchNotes"]
        ),
    ],
    targets: [
        .target(
            name: "LaunchNotes"
        ),
        .target(
            name: "LaunchNotesDemoPreview",
            dependencies: ["LaunchNotes"],
            path: "Examples/LaunchNotesDemo/LaunchNotesDemo",
            exclude: [
                "Assets.xcassets",
                "LaunchNotesDemoApp.swift",
            ],
            sources: ["ContentView.swift"]
        ),
        .testTarget(
            name: "LaunchNotesTests",
            dependencies: ["LaunchNotes"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
