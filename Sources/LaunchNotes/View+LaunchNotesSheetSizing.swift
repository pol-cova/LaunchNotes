import SwiftUI

extension View {
    @ViewBuilder
    func launchNotesSheetSizing(
        noteCount: Int,
        hasSecondaryAction: Bool,
        hasFooterAction: Bool,
        cornerRadius: CGFloat
    ) -> some View {
        #if os(iOS)
        self
            .presentationDetents([
                .height(LaunchNotesSheetMetrics.height(
                    noteCount: noteCount,
                    hasSecondaryAction: hasSecondaryAction,
                    hasFooterAction: hasFooterAction
                )),
                .large,
            ])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(cornerRadius)
            .presentationBackground(.regularMaterial)
        #else
        self
        #endif
    }
}

private enum LaunchNotesSheetMetrics {
    static func height(
        noteCount: Int,
        hasSecondaryAction: Bool,
        hasFooterAction: Bool
    ) -> CGFloat {
        let rowHeight = CGFloat(noteCount) * 66
        let rowSpacing = CGFloat(max(noteCount - 1, 0)) * 16
        let actionsHeight: CGFloat = hasSecondaryAction ? 104 : 54
        let footerHeight: CGFloat = hasFooterAction ? 86 : 0
        let estimatedHeight = 208 + rowHeight + rowSpacing + actionsHeight + footerHeight

        return min(max(estimatedHeight, 500), 740)
    }
}
