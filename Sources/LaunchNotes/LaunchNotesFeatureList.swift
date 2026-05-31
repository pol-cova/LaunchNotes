import SwiftUI

struct LaunchNotesFeatureList: View {
    private let items: [LaunchNoteDisplayItem]
    private let animation: LaunchNotesAnimation
    private let style: LaunchNotesStyle
    private let hasAppeared: Bool

    init(
        notes: [LaunchNote],
        animation: LaunchNotesAnimation,
        style: LaunchNotesStyle,
        hasAppeared: Bool
    ) {
        self.items = notes.enumerated().map { index, note in
            LaunchNoteDisplayItem(index: index, note: note)
        }
        self.animation = animation
        self.style = style
        self.hasAppeared = hasAppeared
    }

    var body: some View {
        VStack(spacing: 16) {
            ForEach(items) { item in
                LaunchNoteRow(
                    note: item.note,
                    accentColor: style.accentColor,
                    cornerRadius: min(style.cornerRadius, 18)
                )
                .frame(maxWidth: .infinity)
                .launchNotesAppearance(
                    index: item.index + 2,
                    animation: animation,
                    hasAppeared: hasAppeared
                )
            }
        }
        .frame(maxWidth: .infinity)
    }
}
