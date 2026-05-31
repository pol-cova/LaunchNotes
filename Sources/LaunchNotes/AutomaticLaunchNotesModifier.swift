import SwiftUI

struct AutomaticLaunchNotesModifier: ViewModifier {
    @Environment(\.launchNotesStyle) private var environmentStyle
    @State private var isPresented = false
    @State private var selectedRelease: LaunchNotesRelease?

    let releases: [LaunchNotesRelease]
    let onSecondaryAction: (() -> Void)?
    let onFooterAction: (() -> Void)?
    let mode: LaunchNotesPresentationMode
    let animation: LaunchNotesAnimation
    let presentation: LaunchNotesPresentation
    let explicitStyle: LaunchNotesStyle?
    let storage: LaunchNotesStorage

    @ViewBuilder
    func body(content: Content) -> some View {
        if let release = selectedRelease ?? releases.first {
            content
                .task {
                    evaluatePresentation()
                }
                .launchNotesPresenter(
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
                    style: effectiveStyle(for: release),
                    markSeen: markSeen
                )
        } else {
            content
        }
    }

    private func evaluatePresentation() {
        selectedRelease = LaunchNotesPresentationPolicy.releaseToPresent(
            from: releases,
            lastSeenVersion: storage.lastSeenVersion(),
            mode: mode
        )
        isPresented = selectedRelease != nil
    }

    private func markSeen() {
        if let version = selectedRelease?.version {
            storage.markSeen(version: version)
        }
    }

    private func effectiveStyle(for release: LaunchNotesRelease) -> LaunchNotesStyle {
        release.style(overriding: explicitStyle ?? environmentStyle)
    }
}
