import SwiftUI

public struct LaunchNotesView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var hasAppeared = false

    private let version: String
    private let title: String
    private let subtitle: String?
    private let buttonTitle: String
    private let secondaryButtonTitle: String?
    private let headerSystemImage: String
    private let notes: [LaunchNote]
    private let animation: LaunchNotesAnimation
    private let style: LaunchNotesStyle
    private let layout: LaunchNotesLayout
    private let onDismiss: (() -> Void)?
    private let onSecondaryAction: (() -> Void)?
    private let footerTitle: String?
    private let onFooterAction: (() -> Void)?

    public init(
        version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        headerSystemImage: String = "sparkles",
        notes: [LaunchNote],
        animation: LaunchNotesAnimation = .smooth,
        style: LaunchNotesStyle = .default,
        onDismiss: (() -> Void)? = nil,
        onSecondaryAction: (() -> Void)? = nil,
        footerTitle: String? = nil,
        onFooterAction: (() -> Void)? = nil
    ) {
        self.init(
            version: version,
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            headerSystemImage: headerSystemImage,
            notes: notes,
            animation: animation,
            style: style,
            layout: .sheet,
            onDismiss: onDismiss,
            onSecondaryAction: onSecondaryAction,
            footerTitle: footerTitle,
            onFooterAction: onFooterAction
        )
    }

    init(
        version: String,
        title: String = "What's New",
        subtitle: String? = nil,
        buttonTitle: String = "Continue",
        secondaryButtonTitle: String? = nil,
        headerSystemImage: String = "sparkles",
        notes: [LaunchNote],
        animation: LaunchNotesAnimation = .smooth,
        style: LaunchNotesStyle = .default,
        layout: LaunchNotesLayout,
        onDismiss: (() -> Void)? = nil,
        onSecondaryAction: (() -> Void)? = nil,
        footerTitle: String? = nil,
        onFooterAction: (() -> Void)? = nil
    ) {
        self.version = version
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.headerSystemImage = headerSystemImage
        self.notes = notes
        self.animation = animation
        self.style = style
        self.layout = layout
        self.onDismiss = onDismiss
        self.onSecondaryAction = onSecondaryAction
        self.footerTitle = footerTitle
        self.onFooterAction = onFooterAction
    }

    public var body: some View {
        GlassEffectContainer(spacing: 14) {
            ZStack(alignment: .topTrailing) {
                LaunchNotesBackground(accentColor: style.accentColor)

                GeometryReader { proxy in
                    ScrollView {
                        LaunchNotesCard(
                            version: version,
                            title: title,
                            subtitle: subtitle,
                            buttonTitle: buttonTitle,
                            secondaryButtonTitle: secondaryButtonTitle,
                            headerSystemImage: headerSystemImage,
                            notes: notes,
                            animation: resolvedAnimation,
                            style: style,
                            layout: layout,
                            footerTitle: footerTitle,
                            hasAppeared: hasAppeared,
                            onPrimaryAction: dismissNotes,
                            onSecondaryAction: secondaryAction,
                            onFooterAction: footerAction
                        )
                        .frame(minHeight: minimumContentHeight(in: proxy.size.height), alignment: .top)
                        .safeAreaPadding(.horizontal, horizontalPadding)
                        .safeAreaPadding(.top, topPadding)
                        .safeAreaPadding(.bottom, bottomPadding)
                    }
                    .scrollBounceBehavior(.basedOnSize)
                }

                LaunchNotesCloseButton(action: dismissNotes)
                    .padding(.top, 18)
                    .padding(.trailing, 18)
                    .launchNotesAppearance(index: 0, animation: resolvedAnimation, hasAppeared: hasAppeared)
            }
        }
        .tint(style.accentColor)
        .task {
            showContent()
        }
    }

    private var resolvedAnimation: LaunchNotesAnimation {
        animation.resolved(reduceMotion: reduceMotion)
    }

    private var horizontalPadding: CGFloat {
        layout == .fullScreen ? 34 : 34
    }

    private var topPadding: CGFloat {
        layout == .fullScreen ? 92 : 36
    }

    private var bottomPadding: CGFloat {
        layout == .fullScreen ? 38 : 22
    }

    private func minimumContentHeight(in availableHeight: CGFloat) -> CGFloat? {
        guard layout == .fullScreen else { return nil }
        return max(0, availableHeight - topPadding - bottomPadding)
    }

    private func dismissNotes() {
        onDismiss?()
        dismiss()
    }

    private func secondaryAction() {
        onSecondaryAction?()
    }

    private func footerAction() {
        onFooterAction?()
    }

    private func showContent() {
        guard !hasAppeared else { return }

        if let baseAnimation = resolvedAnimation.animation {
            withAnimation(baseAnimation) {
                hasAppeared = true
            }
        } else {
            hasAppeared = true
        }
    }
}
