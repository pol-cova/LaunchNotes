@resultBuilder
public enum LaunchNotesReleaseBuilder {
    public static func buildBlock(_ components: LaunchNotesRelease...) -> [LaunchNotesRelease] {
        components
    }

    public static func buildArray(_ components: [[LaunchNotesRelease]]) -> [LaunchNotesRelease] {
        components.flatMap(\.self)
    }

    public static func buildEither(first component: [LaunchNotesRelease]) -> [LaunchNotesRelease] {
        component
    }

    public static func buildEither(second component: [LaunchNotesRelease]) -> [LaunchNotesRelease] {
        component
    }

    public static func buildOptional(_ component: [LaunchNotesRelease]?) -> [LaunchNotesRelease] {
        component ?? []
    }
}
