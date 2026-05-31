import SwiftUI

struct LaunchNotesPresentationContent: View {
    @Binding var isPresented: Bool

    let version: String
    let title: String
    let subtitle: String?
    let buttonTitle: String
    let secondaryButtonTitle: String?
    let onSecondaryAction: (() -> Void)?
    let footerTitle: String?
    let onFooterAction: (() -> Void)?
    let headerSystemImage: String
    let notes: [LaunchNote]
    let animation: LaunchNotesAnimation
    let style: LaunchNotesStyle
    let layout: LaunchNotesLayout

    var body: some View {
        LaunchNotesView(
            version: version,
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            headerSystemImage: headerSystemImage,
            notes: notes,
            animation: animation,
            style: style,
            layout: layout,
            onDismiss: dismiss,
            onSecondaryAction: onSecondaryAction,
            footerTitle: footerTitle,
            onFooterAction: onFooterAction
        )
    }

    private func dismiss() {
        isPresented = false
    }
}
