@resultBuilder
public enum LaunchNotesBuilder {
    public static func buildBlock(_ components: LaunchNote...) -> [LaunchNote] {
        components
    }

    public static func buildArray(_ components: [[LaunchNote]]) -> [LaunchNote] {
        components.flatMap(\.self)
    }

    public static func buildEither(first component: [LaunchNote]) -> [LaunchNote] {
        component
    }

    public static func buildEither(second component: [LaunchNote]) -> [LaunchNote] {
        component
    }

    public static func buildOptional(_ component: [LaunchNote]?) -> [LaunchNote] {
        component ?? []
    }
}
