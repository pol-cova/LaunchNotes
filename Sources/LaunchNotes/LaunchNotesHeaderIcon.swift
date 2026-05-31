import SwiftUI

struct LaunchNotesHeaderIcon: View {
    let systemImage: String
    let style: LaunchNotesStyle
    let animation: LaunchNotesAnimation
    let hasAppeared: Bool

    var body: some View {
        switch style.iconStyle {
        case .circle:
            LaunchNotesHeaderSymbol(systemImage: systemImage, accentColor: style.accentColor)
                .glassEffect(
                    .regular.tint(style.accentColor.opacity(0.16)),
                    in: .circle
                )
                .launchNotesAppearance(index: 0, animation: animation, hasAppeared: hasAppeared)
        case .roundedRectangle:
            LaunchNotesHeaderSymbol(systemImage: systemImage, accentColor: style.accentColor)
                .glassEffect(
                    .regular.tint(style.accentColor.opacity(0.16)),
                    in: .rect(cornerRadius: 20)
                )
                .launchNotesAppearance(index: 0, animation: animation, hasAppeared: hasAppeared)
        }
    }
}
