import Foundation
import SwiftUI

public extension View {
    func launchNotes(
        version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        onSecondaryAction: (() -> Void)? = nil,
        footerTitle: String? = nil,
        onFooterAction: (() -> Void)? = nil,
        headerSystemImage: String = "sparkles",
        notes: [LaunchNote],
        mode: LaunchNotesPresentationMode = .automatic,
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey
    ) -> some View {
        launchNotes(
            releases: [
                LaunchNotesRelease(
                    version,
                    title: title,
                    subtitle: subtitle,
                    buttonTitle: buttonTitle,
                    secondaryButtonTitle: secondaryButtonTitle,
                    headerSystemImage: headerSystemImage,
                    footerTitle: footerTitle,
                    notes: notes
                ),
            ],
            onSecondaryAction: onSecondaryAction,
            onFooterAction: onFooterAction,
            mode: mode,
            animation: animation,
            presentation: presentation,
            style: style,
            userDefaults: userDefaults,
            storageKey: storageKey
        )
    }

    func launchNotes(
        isPresented: Binding<Bool>,
        version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        onSecondaryAction: (() -> Void)? = nil,
        footerTitle: String? = nil,
        onFooterAction: (() -> Void)? = nil,
        headerSystemImage: String = "sparkles",
        notes: [LaunchNote],
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey
    ) -> some View {
        launchNotes(
            isPresented: isPresented,
            release: LaunchNotesRelease(
                version,
                title: title,
                subtitle: subtitle,
                buttonTitle: buttonTitle,
                secondaryButtonTitle: secondaryButtonTitle,
                headerSystemImage: headerSystemImage,
                footerTitle: footerTitle,
                notes: notes
            ),
            onSecondaryAction: onSecondaryAction,
            onFooterAction: onFooterAction,
            animation: animation,
            presentation: presentation,
            style: style,
            userDefaults: userDefaults,
            storageKey: storageKey
        )
    }

    func launchNotes(
        releases: [LaunchNotesRelease],
        onSecondaryAction: (() -> Void)? = nil,
        onFooterAction: (() -> Void)? = nil,
        mode: LaunchNotesPresentationMode = .automatic,
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey
    ) -> some View {
        modifier(
            AutomaticLaunchNotesModifier(
                releases: releases,
                onSecondaryAction: onSecondaryAction,
                onFooterAction: onFooterAction,
                mode: mode,
                animation: animation,
                presentation: presentation,
                explicitStyle: style,
                storage: LaunchNotesStorage(userDefaults: userDefaults, key: storageKey)
            )
        )
    }

    func launchNotes(
        isPresented: Binding<Bool>,
        release: LaunchNotesRelease,
        onSecondaryAction: (() -> Void)? = nil,
        onFooterAction: (() -> Void)? = nil,
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey
    ) -> some View {
        modifier(
            ManualLaunchNotesModifier(
                isPresented: isPresented,
                release: release,
                onSecondaryAction: onSecondaryAction,
                onFooterAction: onFooterAction,
                animation: animation,
                presentation: presentation,
                explicitStyle: style,
                storage: LaunchNotesStorage(userDefaults: userDefaults, key: storageKey)
            )
        )
    }

    func launchNotes(
        onSecondaryAction: (() -> Void)? = nil,
        onFooterAction: (() -> Void)? = nil,
        mode: LaunchNotesPresentationMode = .automatic,
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey,
        @LaunchNotesReleaseBuilder releases: () -> [LaunchNotesRelease]
    ) -> some View {
        launchNotes(
            releases: releases(),
            onSecondaryAction: onSecondaryAction,
            onFooterAction: onFooterAction,
            mode: mode,
            animation: animation,
            presentation: presentation,
            style: style,
            userDefaults: userDefaults,
            storageKey: storageKey
        )
    }

    func launchNotes(
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        onSecondaryAction: (() -> Void)? = nil,
        footerTitle: String? = nil,
        onFooterAction: (() -> Void)? = nil,
        headerSystemImage: String = "sparkles",
        mode: LaunchNotesPresentationMode = .automatic,
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey,
        bundle: Bundle = .main,
        @LaunchNotesBuilder notes: () -> [LaunchNote]
    ) -> some View {
        launchNotes(
            version: LaunchNotesVersion.current(in: bundle),
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            onSecondaryAction: onSecondaryAction,
            footerTitle: footerTitle,
            onFooterAction: onFooterAction,
            headerSystemImage: headerSystemImage,
            notes: notes(),
            mode: mode,
            animation: animation,
            presentation: presentation,
            style: style,
            userDefaults: userDefaults,
            storageKey: storageKey
        )
    }

    func launchNotes(
        version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        onSecondaryAction: (() -> Void)? = nil,
        footerTitle: String? = nil,
        onFooterAction: (() -> Void)? = nil,
        headerSystemImage: String = "sparkles",
        mode: LaunchNotesPresentationMode = .automatic,
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey,
        @LaunchNotesBuilder notes: () -> [LaunchNote]
    ) -> some View {
        launchNotes(
            version: version,
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            onSecondaryAction: onSecondaryAction,
            footerTitle: footerTitle,
            onFooterAction: onFooterAction,
            headerSystemImage: headerSystemImage,
            notes: notes(),
            mode: mode,
            animation: animation,
            presentation: presentation,
            style: style,
            userDefaults: userDefaults,
            storageKey: storageKey
        )
    }

    func launchNotes(
        isPresented: Binding<Bool>,
        version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        onSecondaryAction: (() -> Void)? = nil,
        footerTitle: String? = nil,
        onFooterAction: (() -> Void)? = nil,
        headerSystemImage: String = "sparkles",
        animation: LaunchNotesAnimation = .smooth,
        presentation: LaunchNotesPresentation = .sheet,
        style: LaunchNotesStyle? = nil,
        userDefaults: UserDefaults = .standard,
        storageKey: String = LaunchNotesDefaultStorageKey,
        @LaunchNotesBuilder notes: () -> [LaunchNote]
    ) -> some View {
        launchNotes(
            isPresented: isPresented,
            version: version,
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            onSecondaryAction: onSecondaryAction,
            footerTitle: footerTitle,
            onFooterAction: onFooterAction,
            headerSystemImage: headerSystemImage,
            notes: notes(),
            animation: animation,
            presentation: presentation,
            style: style,
            userDefaults: userDefaults,
            storageKey: storageKey
        )
    }
}
