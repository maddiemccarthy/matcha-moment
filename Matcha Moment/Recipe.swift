import SwiftUI

/// A single matcha recipe. All content ships inside the app, so nothing requires a network connection.
struct Recipe: Identifiable, Hashable {
    enum Difficulty: String {
        case easy = "Easy"
        case medium = "Medium"
        case advanced = "Advanced"
    }

    enum Temperature: String {
        case hot
        case iced
        case chilled

        var label: String {
            switch self {
            case .hot: "Hot"
            case .iced: "Iced"
            case .chilled: "Chilled"
            }
        }

        var symbolName: String {
            switch self {
            case .hot: "flame.fill"
            case .iced: "snowflake"
            case .chilled: "thermometer.snowflake"
            }
        }
    }

    /// Stable identifier used for persisting favorites.
    let id: String
    let name: String
    let tagline: String
    let description: String
    let prepMinutes: Int
    /// Extra time the recipe needs to rest or chill, if any.
    let restTime: String?
    let servings: Int
    let difficulty: Difficulty
    let temperature: Temperature
    let symbolName: String
    let palette: RecipePalette
    let ingredients: [String]
    let steps: [String]
    let tip: String?

    var prepTimeText: String {
        "\(prepMinutes) min"
    }

    var servingsText: String {
        servings == 1 ? "1 serving" : "\(servings) servings"
    }
}

/// Gradient color pairings used on recipe cards and hero headers.
enum RecipePalette: String {
    case ceremonial
    case iced
    case oat
    case berry
    case citrus
    case midnight

    var colors: [Color] {
        switch self {
        case .ceremonial:
            [Color(red: 0.42, green: 0.62, blue: 0.35), Color(red: 0.24, green: 0.42, blue: 0.24)]
        case .iced:
            [Color(red: 0.58, green: 0.78, blue: 0.58), Color(red: 0.33, green: 0.58, blue: 0.48)]
        case .oat:
            [Color(red: 0.70, green: 0.61, blue: 0.40), Color(red: 0.47, green: 0.55, blue: 0.32)]
        case .berry:
            [Color(red: 0.91, green: 0.56, blue: 0.62), Color(red: 0.55, green: 0.66, blue: 0.42)]
        case .citrus:
            [Color(red: 0.82, green: 0.68, blue: 0.30), Color(red: 0.45, green: 0.62, blue: 0.32)]
        case .midnight:
            [Color(red: 0.36, green: 0.52, blue: 0.42), Color(red: 0.18, green: 0.29, blue: 0.25)]
        }
    }

    var gradient: LinearGradient {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
