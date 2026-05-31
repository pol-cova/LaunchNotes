import SwiftUI

extension View {
    @ViewBuilder
    func launchNotesPresenter(
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
        presentation: LaunchNotesPresentation,
        style: LaunchNotesStyle,
        markSeen: @escaping () -> Void
    ) -> some View {
        switch presentation {
        case .sheet:
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
        case .fullScreen:
            launchNotesFullScreenPresenter(
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
                markSeen: markSeen
            )
        }
    }

    func launchNotesPresenter(
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
        animation: LaunchNotesAnimation,
        presentation: LaunchNotesPresentation,
        style: LaunchNotesStyle,
        markSeen: @escaping () -> Void,
        @LaunchNotesBuilder notes: () -> [LaunchNote]
    ) -> some View {
        launchNotesPresenter(
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
            notes: notes(),
            animation: animation,
            presentation: presentation,
            style: style,
            markSeen: markSeen
        )
    }
}
