import SwiftUI

struct LaunchNotesBackground: View {
    let accentColor: Color

    var body: some View {
        Rectangle()
            .fill(.background)
        .ignoresSafeArea()
    }
}
