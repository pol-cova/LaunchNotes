import SwiftUI

public enum LaunchNotesAnimation: Hashable, Sendable {
    case smooth
    case bouncy
    case fade
    case slide
    case none

    internal var animation: Animation? {
        switch self {
        case .smooth:
            .smooth(duration: 0.45)
        case .bouncy:
            .bouncy(duration: 0.62)
        case .fade:
            .easeOut(duration: 0.3)
        case .slide:
            .spring(duration: 0.5, bounce: 0.22)
        case .none:
            nil
        }
    }

    internal func resolved(reduceMotion: Bool) -> LaunchNotesAnimation {
        reduceMotion && self != .none ? .fade : self
    }

    internal func delay(for index: Int) -> Double {
        guard self != .none else { return 0 }
        return Double(index) * 0.075
    }
}
