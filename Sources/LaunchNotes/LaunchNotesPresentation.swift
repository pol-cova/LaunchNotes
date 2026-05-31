public enum LaunchNotesPresentationMode: Hashable, Sendable {
    case automatic
    case always
    case manual
}

public enum LaunchNotesPresentation: Hashable, Sendable {
    case sheet
    case fullScreen
}

internal enum LaunchNotesPresentationPolicy {
    static func shouldPresent(
        version: String,
        lastSeenVersion: String?,
        mode: LaunchNotesPresentationMode
    ) -> Bool {
        switch mode {
        case .automatic:
            lastSeenVersion != version
        case .always:
            true
        case .manual:
            false
        }
    }

    static func releaseToPresent(
        from releases: [LaunchNotesRelease],
        lastSeenVersion: String?,
        mode: LaunchNotesPresentationMode
    ) -> LaunchNotesRelease? {
        switch mode {
        case .automatic:
            guard let latestRelease = releases.first else { return nil }
            return latestRelease.version == lastSeenVersion ? nil : latestRelease
        case .always:
            return releases.first
        case .manual:
            return nil
        }
    }
}
