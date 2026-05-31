# Contributing to LaunchNotes

Thanks for your interest in improving LaunchNotes. This package is intended to stay small, native-feeling, and easy to adopt in SwiftUI apps.

## Goals

LaunchNotes should:

- Feel like a natural SwiftUI API.
- Keep the default setup short.
- Preserve source compatibility when practical.
- Avoid dependencies outside SwiftUI and Foundation.
- Prefer clear public APIs over broad configuration surfaces.
- Keep release-note screens accessible and Dynamic Type friendly.

## Development Setup

Requirements:

- Xcode with Swift 6.3 support
- iOS 26 and macOS 26 SDKs

Open the workspace for package and demo development:

```bash
open LaunchNotes.xcworkspace
```

Run package tests:

```bash
swift test
```

Run the demo app with the `LaunchNotesDemo` scheme.

## Project Layout

- `Sources/LaunchNotes`: package source.
- `Tests/LaunchNotesTests`: package tests.
- `Examples/LaunchNotesDemo`: local iOS demo app.
- `README.md`: public package documentation.

## Pull Request Guidelines

Before opening a pull request:

1. Run `swift test`.
2. Build the `LaunchNotesDemo` scheme.
3. Update README examples if public API changes.
4. Add or update tests for behavior changes.
5. Keep changes focused on one topic.

## API Guidelines

When changing public API:

- Prefer additive changes over breaking changes.
- Keep existing overloads working unless a breaking change is intentional for a major release.
- Use SwiftUI-native names and shapes.
- Keep common usage concise.
- Avoid exposing implementation details from the view hierarchy.
- If an old API name must change, keep a deprecated compatibility alias when possible.

## UI Guidelines

LaunchNotes should stay visually quiet and native:

- Use SwiftUI controls instead of custom tap gestures.
- Respect Dynamic Type and Reduce Motion.
- Keep VoiceOver labels useful.
- Use system images and system fonts.
- Avoid decorative effects that make release notes harder to scan.

## Tests

Add tests for:

- Public model initialization.
- Presentation policy.
- Version and storage behavior.
- Builder APIs.
- Compatibility aliases.

Visual changes should also be checked in the demo app on at least one iPhone simulator.

## License

By contributing, you agree that your contributions will be licensed under the MIT License included in this repository.
