import Foundation

public enum LaunchNotesVersion {
    public static func current(in bundle: Bundle = .main) -> String {
        current(infoDictionary: bundle.infoDictionary)
    }

    internal static func current(infoDictionary: [String: Any]?) -> String {
        stringValue(forKey: "CFBundleShortVersionString", in: infoDictionary)
            ?? stringValue(forKey: "CFBundleVersion", in: infoDictionary)
            ?? "1.0"
    }

    private static func stringValue(forKey key: String, in infoDictionary: [String: Any]?) -> String? {
        guard let value = infoDictionary?[key] as? String else { return nil }
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedValue.isEmpty ? nil : trimmedValue
    }
}
