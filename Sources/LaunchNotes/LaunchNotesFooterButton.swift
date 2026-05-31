import SwiftUI

struct LaunchNotesFooterButton: View {
    let title: String?
    let action: () -> Void

    var body: some View {
        if let title {
            Button(action: action) {
                Text(title)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
            .accessibilityInputLabels([title])
        }
    }
}
