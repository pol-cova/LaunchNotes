import SwiftUI

struct LaunchNotesCard: View {
    let version: String
    let title: String
    let subtitle: String?
    let buttonTitle: String
    let secondaryButtonTitle: String?
    let headerSystemImage: String
    let notes: [LaunchNote]
    let animation: LaunchNotesAnimation
    let style: LaunchNotesStyle
    let layout: LaunchNotesLayout
    let footerTitle: String?
    let hasAppeared: Bool
    let onPrimaryAction: () -> Void
    let onSecondaryAction: () -> Void
    let onFooterAction: () -> Void

    var body: some View {
        VStack(spacing: layout == .fullScreen ? 30 : 24) {
            LaunchNotesHeader(
                version: version,
                title: title,
                subtitle: subtitle,
                systemImage: headerSystemImage,
                style: style,
                animation: animation,
                hasAppeared: hasAppeared
            )

            LaunchNotesFeatureList(
                notes: notes,
                animation: animation,
                style: style,
                hasAppeared: hasAppeared
            )

            if layout == .fullScreen {
                Spacer(minLength: 12)
            }

            LaunchNotesActions(
                buttonTitle: buttonTitle,
                secondaryButtonTitle: secondaryButtonTitle,
                footerTitle: footerTitle,
                buttonLayout: style.buttonLayout,
                animation: animation,
                appearanceIndex: notes.count + 2,
                hasAppeared: hasAppeared,
                onPrimaryAction: onPrimaryAction,
                onSecondaryAction: onSecondaryAction,
                onFooterAction: onFooterAction
            )
        }
        .padding(.vertical, 0)
        .frame(maxWidth: 560)
    }
}
