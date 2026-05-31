import SwiftUI

struct LaunchNotesAppearanceModifier: ViewModifier {
    let index: Int
    let animation: LaunchNotesAnimation
    let hasAppeared: Bool

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: offset)
            .animation(animation.animation?.delay(animation.delay(for: index)), value: hasAppeared)
    }

    private var opacity: Double {
        animation == .none || hasAppeared ? 1 : 0
    }

    private var offset: CGFloat {
        guard animation != .none, !hasAppeared else { return 0 }

        switch animation {
        case .slide:
            return 24
        case .smooth, .bouncy:
            return 14
        case .fade, .none:
            return 0
        }
    }
}
