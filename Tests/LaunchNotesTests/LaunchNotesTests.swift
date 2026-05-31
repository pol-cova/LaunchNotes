import Foundation
import SwiftUI
import Testing
@testable import LaunchNotes

@Suite("LaunchNotes")
struct LaunchNotesTests {
    @Test("LaunchNote initializes with title, description, icon, and unique identity")
    func launchNoteInitialization() {
        let first = LaunchNote("New Timer", "Focus sessions are more reliable.", icon: "timer")
        let second = LaunchNote("New Timer", "Focus sessions are more reliable.", icon: "timer")

        #expect(first.title == "New Timer")
        #expect(first.description == "Focus sessions are more reliable.")
        #expect(first.icon == "timer")
        #expect(first.id != second.id)
        #expect(first != second)
    }

    @Test("Presentation policy follows automatic, always, and manual modes")
    func presentationPolicy() {
        #expect(
            LaunchNotesPresentationPolicy.shouldPresent(
                version: "1.2.0",
                lastSeenVersion: "1.1.0",
                mode: .automatic
            )
        )
        #expect(
            !LaunchNotesPresentationPolicy.shouldPresent(
                version: "1.2.0",
                lastSeenVersion: "1.2.0",
                mode: .automatic
            )
        )
        #expect(
            LaunchNotesPresentationPolicy.shouldPresent(
                version: "1.2.0",
                lastSeenVersion: "1.2.0",
                mode: .always
            )
        )
        #expect(
            !LaunchNotesPresentationPolicy.shouldPresent(
                version: "1.2.0",
                lastSeenVersion: "1.1.0",
                mode: .manual
            )
        )
    }

    @Test("Storage reads and writes isolated UserDefaults suite")
    func storageReadWrite() {
        let suiteName = "LaunchNotesTests.storageReadWrite.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        defer { userDefaults.removePersistentDomain(forName: suiteName) }

        let storage = LaunchNotesStorage(userDefaults: userDefaults, key: "seen")

        #expect(storage.lastSeenVersion() == nil)
        #expect(!storage.hasSeen(version: "1.2.0"))

        storage.markSeen(version: "1.2.0")

        #expect(storage.lastSeenVersion() == "1.2.0")
        #expect(storage.hasSeen(version: "1.2.0"))
        #expect(!storage.hasSeen(version: "1.2.1"))
    }

    @Test("Mark seen updates presentation decision")
    func markSeenUpdatesPresentationDecision() {
        let suiteName = "LaunchNotesTests.markSeen.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        defer { userDefaults.removePersistentDomain(forName: suiteName) }

        let storage = LaunchNotesStorage(userDefaults: userDefaults, key: "seen")
        #expect(
            LaunchNotesPresentationPolicy.shouldPresent(
                version: "2.0.0",
                lastSeenVersion: storage.lastSeenVersion(),
                mode: .automatic
            )
        )

        storage.markSeen(version: "2.0.0")

        #expect(
            !LaunchNotesPresentationPolicy.shouldPresent(
                version: "2.0.0",
                lastSeenVersion: storage.lastSeenVersion(),
                mode: .automatic
            )
        )
    }

    @Test("Style defaults and custom overrides are preserved")
    func styleDefaultsAndOverrides() {
        let defaultStyle = LaunchNotesStyle.default
        #expect(defaultStyle.cornerRadius == 18)
        #expect(defaultStyle.iconStyle == .circle)
        #expect(!defaultStyle.showsHeaderIcon)
        #expect(defaultStyle.buttonLayout == .vertical)

        let customStyle = LaunchNotesStyle(
            glassTint: .purple,
            cornerRadius: 32,
            iconStyle: .roundedRectangle,
            showsHeaderIcon: false,
            buttonLayout: .horizontal
        )

        #expect(customStyle.cornerRadius == 32)
        #expect(customStyle.iconStyle == .roundedRectangle)
        #expect(!customStyle.showsHeaderIcon)
        #expect(customStyle.buttonLayout == .horizontal)
    }

    @Test("Style presets configure common appearances")
    func stylePresets() {
        #expect(LaunchNotesStyle.compact.cornerRadius == 14)
        #expect(LaunchNotesStyle.prominent.showsHeaderIcon)
        #expect(!LaunchNotesStyle.minimal.showsHeaderIcon)
    }

    @available(*, deprecated, message: "Validates deprecated compatibility API.")
    @Test("Deprecated showsAppIcon alias mirrors showsHeaderIcon")
    func deprecatedShowsAppIconAlias() {
        var style = LaunchNotesStyle(showsAppIcon: true)

        #expect(style.showsHeaderIcon)
        style.showsAppIcon = false
        #expect(!style.showsHeaderIcon)
    }

    @Test("Builder creates launch notes from a trailing closure")
    func builderCreatesLaunchNotes() {
        let notes = LaunchNotesBuilder.buildBlock(
            LaunchNote("One", "First note.", systemImage: "1.circle"),
            LaunchNote("Two", "Second note.", icon: "2.circle")
        )

        #expect(notes.count == 2)
        #expect(notes[0].icon == "1.circle")
        #expect(notes[1].title == "Two")
    }

    @Test("Release builder creates versioned release history")
    func releaseBuilderCreatesVersionedHistory() {
        let releases = LaunchNotesReleaseBuilder.buildBlock(
            LaunchNotesRelease(
                "2.0.0",
                title: "What's New in 2.0",
                accentColor: .purple,
                footerTitle: "About Privacy"
            ) {
                LaunchNote("Redesigned", "A cleaner interface.", systemImage: "sparkles")
            },
            LaunchNotesRelease("1.5.0") {
                LaunchNote("Search", "Find content faster.", systemImage: "magnifyingglass")
            }
        )

        #expect(releases.count == 2)
        #expect(releases[0].id == "2.0.0")
        #expect(releases[0].title == "What's New in 2.0")
        #expect(releases[0].accentColor != nil)
        #expect(releases[0].footerTitle == "About Privacy")
        #expect(releases[1].notes[0].icon == "magnifyingglass")
    }

    @Test("Release accent overrides base style")
    func releaseAccentOverridesBaseStyle() {
        let release = LaunchNotesRelease("2.0.0", accentColor: .purple) {
            LaunchNote("Redesigned", "A cleaner interface.", systemImage: "sparkles")
        }

        let style = release.style(overriding: .init(accentColor: .blue))

        #expect(String(describing: style.accentColor) == String(describing: Color.purple))
    }

    @Test("Current version resolves bundle metadata with fallback")
    func currentVersionResolution() {
        #expect(
            LaunchNotesVersion.current(infoDictionary: [
                "CFBundleShortVersionString": "2.3.0",
                "CFBundleVersion": "45",
            ]) == "2.3.0"
        )
        #expect(
            LaunchNotesVersion.current(infoDictionary: [
                "CFBundleVersion": "45",
            ]) == "45"
        )
        #expect(LaunchNotesVersion.current(infoDictionary: nil) == "1.0")
    }

    @Test("Release can default to current bundle version")
    func releaseDefaultsToBundleVersion() {
        let release = LaunchNotesRelease(title: "Fresh Updates", bundle: .main) {
            LaunchNote("One", "First note.", systemImage: "1.circle")
        }

        #expect(!release.version.isEmpty)
        #expect(release.title == "Fresh Updates")
    }

    @MainActor
    @Test("Zero-config modifier accepts note builder")
    func zeroConfigModifierAcceptsNoteBuilder() {
        let view = Text("Home").launchNotes {
            LaunchNote("One", "First note.", systemImage: "1.circle")
        }

        _ = view
    }

    @Test("Release policy presents newest unseen release")
    func releasePolicyPresentsNewestUnseenRelease() {
        let releases = [
            LaunchNotesRelease("2.0.0") {
                LaunchNote("New Design", "A cleaner interface.", systemImage: "sparkles")
            },
            LaunchNotesRelease("1.5.0") {
                LaunchNote("Search", "Find content faster.", systemImage: "magnifyingglass")
            },
        ]

        let unseenRelease = LaunchNotesPresentationPolicy.releaseToPresent(
            from: releases,
            lastSeenVersion: "1.5.0",
            mode: .automatic
        )
        let alreadySeenLatestRelease = LaunchNotesPresentationPolicy.releaseToPresent(
            from: releases,
            lastSeenVersion: "2.0.0",
            mode: .automatic
        )
        let manualRelease = LaunchNotesPresentationPolicy.releaseToPresent(
            from: releases,
            lastSeenVersion: nil,
            mode: .manual
        )

        #expect(unseenRelease?.version == "2.0.0")
        #expect(alreadySeenLatestRelease == nil)
        #expect(manualRelease == nil)
    }
}
