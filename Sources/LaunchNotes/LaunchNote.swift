import Foundation

public struct LaunchNote: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let title: String
    public let description: String
    public let icon: String?

    public init(
        _ title: String,
        _ description: String,
        icon: String? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.icon = icon
    }

    public init(
        _ title: String,
        _ description: String,
        systemImage: String
    ) {
        self.init(title, description, icon: systemImage)
    }

    internal init(
        id: UUID,
        title: String,
        description: String,
        icon: String? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.icon = icon
    }
}
