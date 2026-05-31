import SwiftUI

struct LaunchNotesHeader: View {
    let version: String
    let title: String
    let subtitle: String?
    let systemImage: String
    let style: LaunchNotesStyle
    let animation: LaunchNotesAnimation
    let hasAppeared: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            if style.showsHeaderIcon {
                LaunchNotesHeaderIcon(
                    systemImage: systemImage,
                    style: style,
                    animation: animation,
                    hasAppeared: hasAppeared
                )
            }

            LaunchNotesTitleBlock(
                version: version,
                title: title,
                subtitle: subtitle,
                animation: animation,
                hasAppeared: hasAppeared
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
