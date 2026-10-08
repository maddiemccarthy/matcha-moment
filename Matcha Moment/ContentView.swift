import SwiftUI

struct ContentView: View {
    @Environment(FavoritesStore.self) private var favorites

    var body: some View {
        TabView {
            Tab("Recipes", systemImage: "leaf.fill") {
                HomeView()
            }

            Tab("Favorites", systemImage: "heart.fill") {
                FavoritesView()
            }
            .badge(favorites.count)
        }
        .tint(MatchaTheme.matchaDeep)
    }
}

#Preview {
    ContentView()
        .environment(FavoritesStore())
}
