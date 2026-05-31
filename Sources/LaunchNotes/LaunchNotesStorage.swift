import Foundation

internal struct LaunchNotesStorage {
    static let defaultKey = LaunchNotesDefaultStorageKey

    private let userDefaults: UserDefaults
    private let key: String

    init(
        userDefaults: UserDefaults = .standard,
        key: String = LaunchNotesStorage.defaultKey
    ) {
        self.userDefaults = userDefaults
        self.key = key
    }

    func lastSeenVersion() -> String? {
        userDefaults.string(forKey: key)
    }

    func hasSeen(version: String) -> Bool {
        lastSeenVersion() == version
    }

    func markSeen(version: String) {
        userDefaults.set(version, forKey: key)
    }
}

public let LaunchNotesDefaultStorageKey = "LaunchNotes.lastSeenVersion"
