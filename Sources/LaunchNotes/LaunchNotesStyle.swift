import CoreGraphics
import SwiftUI

public enum LaunchNotesIconStyle: Hashable, Sendable {
    case circle
    case roundedRectangle
}

public enum LaunchNotesButtonLayout: Hashable, Sendable {
    case vertical
    case horizontal
}

public struct LaunchNotesStyle: Sendable {
    public var accentColor: Color
    public var glassTint: Color?
    public var cornerRadius: CGFloat
    public var iconStyle: LaunchNotesIconStyle
    public var showsHeaderIcon: Bool
    public var buttonLayout: LaunchNotesButtonLayout

    public init(
        accentColor: Color = .blue,
        glassTint: Color? = nil,
        cornerRadius: CGFloat = 18,
        iconStyle: LaunchNotesIconStyle = .circle,
        showsHeaderIcon: Bool = false,
        buttonLayout: LaunchNotesButtonLayout = .vertical
    ) {
        self.accentColor = accentColor
        self.glassTint = glassTint
        self.cornerRadius = cornerRadius
        self.iconStyle = iconStyle
        self.showsHeaderIcon = showsHeaderIcon
        self.buttonLayout = buttonLayout
    }

    public static let `default` = LaunchNotesStyle()
    public static let compact = LaunchNotesStyle(cornerRadius: 14)
    public static let prominent = LaunchNotesStyle(cornerRadius: 22, showsHeaderIcon: true)
    public static let minimal = LaunchNotesStyle(cornerRadius: 12, showsHeaderIcon: false)
}

public extension LaunchNotesStyle {
    @available(*, deprecated, renamed: "showsHeaderIcon")
    var showsAppIcon: Bool {
        get { showsHeaderIcon }
        set { showsHeaderIcon = newValue }
    }

    @available(*, deprecated, message: "Use init(accentColor:glassTint:cornerRadius:iconStyle:showsHeaderIcon:buttonLayout:) instead.")
    init(
        accentColor: Color = .blue,
        glassTint: Color? = nil,
        cornerRadius: CGFloat = 18,
        iconStyle: LaunchNotesIconStyle = .circle,
        showsAppIcon: Bool,
        buttonLayout: LaunchNotesButtonLayout = .vertical
    ) {
        self.init(
            accentColor: accentColor,
            glassTint: glassTint,
            cornerRadius: cornerRadius,
            iconStyle: iconStyle,
            showsHeaderIcon: showsAppIcon,
            buttonLayout: buttonLayout
        )
    }
}

extension EnvironmentValues {
    @Entry var launchNotesStyle: LaunchNotesStyle = .default
}

public extension View {
    func launchNotesStyle(_ style: LaunchNotesStyle) -> some View {
        environment(\.launchNotesStyle, style)
    }
}
