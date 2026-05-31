import SwiftUI

struct LaunchNotesActions: View {
    let buttonTitle: String
    let secondaryButtonTitle: String?
    let footerTitle: String?
    let buttonLayout: LaunchNotesButtonLayout
    let animation: LaunchNotesAnimation
    let appearanceIndex: Int
    let hasAppeared: Bool
    let onPrimaryAction: () -> Void
    let onSecondaryAction: () -> Void
    let onFooterAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            LaunchNotesFooterButton(title: footerTitle, action: onFooterAction)

            switch buttonLayout {
            case .vertical:
                VStack(spacing: 10) {
                    LaunchNotesPrimaryButton(title: buttonTitle, action: onPrimaryAction)
                    LaunchNotesSecondaryButton(title: secondaryButtonTitle, action: onSecondaryAction)
                }
            case .horizontal:
                HStack(spacing: 10) {
                    LaunchNotesPrimaryButton(title: buttonTitle, action: onPrimaryAction)
                    LaunchNotesSecondaryButton(title: secondaryButtonTitle, action: onSecondaryAction)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
        .launchNotesAppearance(index: appearanceIndex, animation: animation, hasAppeared: hasAppeared)
    }
}
