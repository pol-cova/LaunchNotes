import SwiftUI

struct LaunchNotesCloseButton: View {
    let action: () -> Void

    var body: some View {
        Button("Close", systemImage: "xmark", action: action)
            .labelStyle(.iconOnly)
            .font(.system(.callout, weight: .semibold))
            .imageScale(.medium)
            .frame(width: 44, height: 44)
            .contentShape(Circle())
            .buttonStyle(.glass)
            .accessibilityInputLabels(["Close", "Dismiss"])
    }
}
