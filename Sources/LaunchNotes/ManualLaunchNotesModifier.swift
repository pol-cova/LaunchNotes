import SwiftUI

struct ManualLaunchNotesModifier: ViewModifier {
    @Environment(\.launchNotesStyle) private var environmentStyle
    @Binding var isPresented: Bool

    let release: LaunchNotesRelease
    let onSecondaryAction: (() -> Void)?
    let onFooterAction: (() -> Void)?
    let animation: LaunchNotesAnimation
    let presentation: LaunchNotesPresentation
    let explicitStyle: LaunchNotesStyle?
    let storage: LaunchNotesStorage

    func body(content: Content) -> some View {
        content.launchNotesPresenter(
            isPresented: $isPresented,
            version: release.version,
            title: release.title,
            subtitle: release.subtitle,
            buttonTitle: release.buttonTitle,
            secondaryButtonTitle: release.secondaryButtonTitle,
            onSecondaryAction: onSecondaryAction,
            footerTitle: release.footerTitle,
            onFooterAction: onFooterAction,
            headerSystemImage: release.headerSystemImage,
            notes: release.notes,
            animation: animation,
            presentation: presentation,
            style: effectiveStyle,
            markSeen: markSeen
        )
    }

    private func markSeen() {
        storage.markSeen(version: release.version)
    }

    private var effectiveStyle: LaunchNotesStyle {
        release.style(overriding: explicitStyle ?? environmentStyle)
    }
}
