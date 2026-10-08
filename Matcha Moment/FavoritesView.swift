import SwiftUI

/// Saved recipes, read from the persisted FavoritesStore.
struct FavoritesView: View {
    @Environment(FavoritesStore.self) private var favorites

    private var favoriteRecipes: [Recipe] {
        RecipeLibrary.all.filter { favorites.isFavorite($0) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if favoriteRecipes.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(favoriteRecipes) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeRowView(recipe: recipe)
                                }
                                .buttonStyle(PressableButtonStyle())
                            }
                        }
                        .padding(20)
                        .animation(.spring(duration: 0.35), value: favoriteRecipes)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(MatchaTheme.cream.ignoresSafeArea())
            .navigationTitle("Favorites")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart")
                .font(.system(size: 44, weight: .medium))
                .foregroundStyle(MatchaTheme.matchaDeep)
                .frame(width: 104, height: 104)
                .background(MatchaTheme.matchaLight.opacity(0.6), in: Circle())
            Text("No favorites yet")
                .font(.title3.weight(.semibold))
                .foregroundStyle(MatchaTheme.ink)
            Text("Tap the heart on any recipe to keep it here. Your favorites are saved on this device, so they're always ready, even offline.")
                .font(.subheadline)
                .foregroundStyle(MatchaTheme.inkSoft)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    FavoritesView()
        .environment(FavoritesStore())
}
