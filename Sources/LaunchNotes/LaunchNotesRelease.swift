import Foundation
import SwiftUI

public struct LaunchNotesRelease: Identifiable, Hashable, Sendable {
    public var id: String { version }

    public let version: String
    public let title: String
    public let subtitle: String?
    public let buttonTitle: String
    public let secondaryButtonTitle: String?
    public let headerSystemImage: String
    public let accentColor: Color?
    public let footerTitle: String?
    public let notes: [LaunchNote]

    public init(
        _ version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        headerSystemImage: String = "sparkles",
        accentColor: Color? = nil,
        footerTitle: String? = nil,
        notes: [LaunchNote]
    ) {
        self.version = version
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.headerSystemImage = headerSystemImage
        self.accentColor = accentColor
        self.footerTitle = footerTitle
        self.notes = notes
    }

    public init(
        _ version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        headerSystemImage: String = "sparkles",
        accentColor: Color? = nil,
        footerTitle: String? = nil,
        @LaunchNotesBuilder notes: () -> [LaunchNote]
    ) {
        self.init(
            version,
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            headerSystemImage: headerSystemImage,
            accentColor: accentColor,
            footerTitle: footerTitle,
            notes: notes()
        )
    }

    public init(
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        headerSystemImage: String = "sparkles",
        accentColor: Color? = nil,
        footerTitle: String? = nil,
        bundle: Bundle = .main,
        notes: [LaunchNote]
    ) {
        self.init(
            LaunchNotesVersion.current(in: bundle),
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            headerSystemImage: headerSystemImage,
            accentColor: accentColor,
            footerTitle: footerTitle,
            notes: notes
        )
    }

    public init(
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        headerSystemImage: String = "sparkles",
        accentColor: Color? = nil,
        footerTitle: String? = nil,
        bundle: Bundle = .main,
        @LaunchNotesBuilder notes: () -> [LaunchNote]
    ) {
        self.init(
            LaunchNotesVersion.current(in: bundle),
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            headerSystemImage: headerSystemImage,
            accentColor: accentColor,
            footerTitle: footerTitle,
            notes: notes()
        )
    }
}

extension LaunchNotesRelease {
    func style(overriding baseStyle: LaunchNotesStyle) -> LaunchNotesStyle {
        var style = baseStyle
        if let accentColor {
            style.accentColor = accentColor
        }
        return style
    }
}
