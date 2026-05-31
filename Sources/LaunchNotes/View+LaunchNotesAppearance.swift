import SwiftUI

extension View {
    func launchNotesAppearance(
        index: Int,
        animation: LaunchNotesAnimation,
        hasAppeared: Bool
    ) -> some View {
        modifier(
            LaunchNotesAppearanceModifier(
                index: index,
                animation: animation,
                hasAppeared: hasAppeared
            )
        )
    }
}
