import SwiftUI

struct LaunchNoteRow: View {
    let note: LaunchNote
    let accentColor: Color
    let cornerRadius: CGFloat

    var body: some View {
        HStack(alignment: .top, spacing: 18) {
            Image(systemName: note.icon ?? "sparkle")
                .font(.system(.title, weight: .regular))
                .foregroundStyle(accentColor)
                .frame(width: 42, alignment: .center)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 3) {
                Text(note.title)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                Text(note.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }
}
