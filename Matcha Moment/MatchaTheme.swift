import SwiftUI

/// Shared colors and metrics for the Matcha Moment look: soft cream surfaces with matcha-green accents.
enum MatchaTheme {
    static let cream = Color(red: 0.98, green: 0.96, blue: 0.91)
    static let creamDeep = Color(red: 0.95, green: 0.92, blue: 0.84)
    static let card = Color.white.opacity(0.88)

    static let matcha = Color(red: 0.47, green: 0.64, blue: 0.38)
    static let matchaDeep = Color(red: 0.29, green: 0.45, blue: 0.27)
    static let matchaLight = Color(red: 0.80, green: 0.88, blue: 0.70)

    static let ink = Color(red: 0.16, green: 0.20, blue: 0.14)
    static let inkSoft = Color(red: 0.40, green: 0.44, blue: 0.37)
    static let rose = Color(red: 0.86, green: 0.36, blue: 0.42)

    static let cardCornerRadius: CGFloat = 24
    static let heroCornerRadius: CGFloat = 28
}

/// A gentle press animation for prominent buttons.
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.spring(duration: 0.25, bounce: 0.3), value: configuration.isPressed)
    }
}

/// Section title with an optional supporting line.
struct SectionHeader: View {
    let title: String
    var subtitle: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(MatchaTheme.ink)
            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(MatchaTheme.inkSoft)
            }
        }
    }
}
