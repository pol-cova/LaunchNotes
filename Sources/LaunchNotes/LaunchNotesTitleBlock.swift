import SwiftUI

struct LaunchNotesTitleBlock: View {
    let version: String
    let title: String
    let subtitle: String?
    let animation: LaunchNotesAnimation
    let hasAppeared: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.82)
                .fixedSize(horizontal: false, vertical: true)

            Text("Version \(version)")
                .font(.headline)
                .foregroundStyle(.secondary)

            if let subtitle {
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: 440, alignment: .leading)
        .launchNotesAppearance(index: 1, animation: animation, hasAppeared: hasAppeared)
    }
}
