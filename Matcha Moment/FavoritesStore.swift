import Foundation
import Observation

/// Keeps track of favorited recipes and persists them locally in UserDefaults,
/// so favorites survive app relaunches and work fully offline.
@Observable
final class FavoritesStore {
    private static let storageKey = "matchaMoment.favoriteRecipeIDs"

    private(set) var favoriteIDs: Set<String>
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        favoriteIDs = Set(defaults.stringArray(forKey: Self.storageKey) ?? [])
    }

    var count: Int {
        favoriteIDs.count
    }

    func isFavorite(_ recipe: Recipe) -> Bool {
        favoriteIDs.contains(recipe.id)
    }

    func toggle(_ recipe: Recipe) {
        if favoriteIDs.contains(recipe.id) {
            favoriteIDs.remove(recipe.id)
        } else {
            favoriteIDs.insert(recipe.id)
        }
        persist()
    }

    private func persist() {
        defaults.set(favoriteIDs.sorted(), forKey: Self.storageKey)
    }
}
