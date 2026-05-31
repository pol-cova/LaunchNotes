import SwiftUI

struct LaunchNotesHeaderSymbol: View {
    let systemImage: String
    let accentColor: Color

    var body: some View {
        Image(systemName: systemImage)
            .font(.system(.largeTitle, weight: .semibold))
            .foregroundStyle(.white, accentColor)
            .symbolRenderingMode(.palette)
            .frame(width: 72, height: 72)
            .accessibilityHidden(true)
    }
}
