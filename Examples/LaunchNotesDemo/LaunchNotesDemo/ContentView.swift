import Foundation
import LaunchNotes
import SwiftUI

struct ContentView: View {
    @State private var showManualNotes = false
    @State private var showFullScreenNotes = false
    @State private var showFooterNotes = false
    @State private var previewVersion = "1.2.0"

    private let notes: [LaunchNote] = [
        .init("Daily Challenges", "Come back every day for a new challenge.", systemImage: "calendar"),
        .init("New Stats", "Track your progress with cleaner charts.", systemImage: "chart.line.uptrend.xyaxis"),
        .init("Smoother Animations", "The app now feels faster and more polished.", systemImage: "sparkles"),
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Image(systemName: "paperplane.circle.fill")
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.blue)

                        Text("LaunchNotes")
                            .font(.largeTitle.bold())

                        Text("A tiny demo app for trying automatic, manual, sheet, full-screen, and styled release notes.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 12)
                }

                Section("Presentation") {
                    Button("Show manual sheet") {
                        showManualNotes = true
                    }

                    Button("Show full-screen cover") {
                        showFullScreenNotes = true
                    }

                    Button("Show footer action sheet") {
                        showFooterNotes = true
                    }

                    Button("Reset automatic version tracking") {
                        UserDefaults.standard.removeObject(forKey: LaunchNotesDefaultStorageKey)
                        previewVersion = "1.2.0-reset-\(Int(Date().timeIntervalSince1970))"
                    }
                }

                Section("Sample Notes") {
                    ForEach(notes) { note in
                        Label {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(note.title)
                                Text(note.description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        } icon: {
                            Image(systemName: note.icon ?? "sparkle")
                        }
                    }
                }
            }
            .navigationTitle("Demo")
        }
        .launchNotes(
            animation: .bouncy,
            presentation: .sheet,
            style: .init(
                accentColor: .blue,
                cornerRadius: 18,
                iconStyle: .roundedRectangle
            )
        ) {
            LaunchNotesRelease(
                previewVersion,
                title: "Fresh Updates",
                subtitle: "This appears automatically when the version has not been seen.",
                buttonTitle: "Looks good"
            ) {
                LaunchNote("Daily Challenges", "Come back every day for a new challenge.", systemImage: "calendar")
                LaunchNote("New Stats", "Track your progress with cleaner charts.", systemImage: "chart.line.uptrend.xyaxis")
                LaunchNote("Smoother Animations", "The app now feels faster and more polished.", systemImage: "sparkles")
            }

            LaunchNotesRelease(
                "1.1.0",
                title: "Previous Updates",
                accentColor: .green
            ) {
                LaunchNote("Release History", "Older releases can live beside the current release.", systemImage: "clock.arrow.circlepath")
            }
        }
        .launchNotes(
            isPresented: $showFooterNotes,
            release: LaunchNotesRelease(
                title: "Bundle Version Preview",
                subtitle: "This release uses LaunchNotesVersion.current() automatically.",
                buttonTitle: "Done",
                accentColor: .teal,
                footerTitle: "About LaunchNotes Privacy",
                notes: notes
            ),
            onFooterAction: {
                showFooterNotes = false
            },
            animation: .smooth,
            presentation: .sheet,
            style: .compact
        )
        .launchNotes(
            isPresented: $showManualNotes,
            release: LaunchNotesRelease(
                "1.2.0",
                title: "Manual Preview",
                subtitle: "The binding overload is useful for settings screens, debug menus, and release history.",
                buttonTitle: "Done",
                secondaryButtonTitle: "Not now",
                notes: notes
            ),
            onSecondaryAction: {
                showManualNotes = false
            },
            animation: .smooth,
            presentation: .sheet,
            style: .init(
                accentColor: .purple,
                buttonLayout: .vertical
            )
        )
        .launchNotes(
            isPresented: $showFullScreenNotes,
            release: LaunchNotesRelease(
                "1.2.0",
                title: "Full-Screen Preview",
                subtitle: "This uses the full-screen presentation style on iOS.",
                buttonTitle: "Close",
                notes: notes
            ),
            animation: .bouncy,
            presentation: .fullScreen,
            style: .prominent
        )
    }
}


#Preview {
    ContentView()
}
