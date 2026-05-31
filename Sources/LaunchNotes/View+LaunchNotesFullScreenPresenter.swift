import SwiftUI

extension View {
    @ViewBuilder
    func launchNotesFullScreenPresenter(
        isPresented: Binding<Bool>,
        version: String,
        title: String,
        subtitle: String?,
        buttonTitle: String,
        secondaryButtonTitle: String?,
        onSecondaryAction: (() -> Void)?,
        footerTitle: String?,
        onFooterAction: (() -> Void)?,
        headerSystemImage: String,
        notes: [LaunchNote],
        animation: LaunchNotesAnimation,
        style: LaunchNotesStyle,
        markSeen: @escaping () -> Void
    ) -> some View {
        #if os(iOS)
        fullScreenCover(isPresented: isPresented, onDismiss: markSeen) {
            LaunchNotesPresentationContent(
                isPresented: isPresented,
                version: version,
                title: title,
                subtitle: subtitle,
                buttonTitle: buttonTitle,
                secondaryButtonTitle: secondaryButtonTitle,
                onSecondaryAction: onSecondaryAction,
                footerTitle: footerTitle,
                onFooterAction: onFooterAction,
                headerSystemImage: headerSystemImage,
                notes: notes,
                animation: animation,
                style: style,
                layout: .fullScreen
            )
        }
        #else
        sheet(isPresented: isPresented, onDismiss: markSeen) {
            LaunchNotesPresentationContent(
                isPresented: isPresented,
                version: version,
                title: title,
                subtitle: subtitle,
                buttonTitle: buttonTitle,
                secondaryButtonTitle: secondaryButtonTitle,
                onSecondaryAction: onSecondaryAction,
                footerTitle: footerTitle,
                onFooterAction: onFooterAction,
                headerSystemImage: headerSystemImage,
                notes: notes,
                animation: animation,
                style: style,
                layout: .sheet
            )
            .launchNotesSheetSizing(
                noteCount: notes.count,
                hasSecondaryAction: secondaryButtonTitle != nil,
                hasFooterAction: footerTitle != nil,
                cornerRadius: style.cornerRadius
            )
        }
        #endif
    }
}
