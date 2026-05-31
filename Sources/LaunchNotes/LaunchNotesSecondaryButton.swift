import SwiftUI

struct LaunchNotesSecondaryButton: View {
    let title: String?
    let action: () -> Void

    var body: some View {
        if let title {
            Button(action: action) {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .contentShape(.rect)
            }
                .buttonStyle(.plain)
                .foregroundStyle(.tint)
                .accessibilityInputLabels([title, "Later"])
        }
    }
}
