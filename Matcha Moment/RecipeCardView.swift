import SwiftUI

/// Rounded grid card showing a recipe at a glance, with a favorite toggle.
struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(recipe.palette.gradient)
                    .frame(height: 110)
                    .overlay {
                        Image(systemName: recipe.symbolName)
                            .font(.system(size: 40, weight: .medium))
                            .foregroundStyle(.white.opacity(0.95))
                    }

                FavoriteButton(recipe: recipe, compact: true)
                    .padding(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(MatchaTheme.ink)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2, reservesSpace: true)
                Text(recipe.tagline)
                    .font(.caption)
                    .foregroundStyle(MatchaTheme.inkSoft)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2, reservesSpace: true)
            }

            HStack {
                Label(recipe.prepTimeText, systemImage: "clock")
                Spacer()
                Label(recipe.temperature.label, systemImage: recipe.temperature.symbolName)
            }
            .font(.caption2.weight(.semibold))
            .foregroundStyle(MatchaTheme.matchaDeep)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(MatchaTheme.card, in: RoundedRectangle(cornerRadius: MatchaTheme.cardCornerRadius, style: .continuous))
        .shadow(color: MatchaTheme.matchaDeep.opacity(0.10), radius: 12, y: 6)
    }
}

/// Wide horizontal card used in the Favorites list.
struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(recipe.palette.gradient)
                .frame(width: 76, height: 76)
                .overlay {
                    Image(systemName: recipe.symbolName)
                        .font(.system(size: 30, weight: .medium))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(MatchaTheme.ink)
                Text(recipe.tagline)
                    .font(.caption)
                    .foregroundStyle(MatchaTheme.inkSoft)
                    .lineLimit(2)
                HStack(spacing: 10) {
                    Label(recipe.prepTimeText, systemImage: "clock")
                    Label(recipe.servingsText, systemImage: "person.2")
                }
                .font(.caption2.weight(.semibold))
                .foregroundStyle(MatchaTheme.matchaDeep)
            }
            .multilineTextAlignment(.leading)

            Spacer(minLength: 0)

            FavoriteButton(recipe: recipe)
        }
        .padding(14)
        .background(MatchaTheme.card, in: RoundedRectangle(cornerRadius: MatchaTheme.cardCornerRadius, style: .continuous))
        .shadow(color: MatchaTheme.matchaDeep.opacity(0.10), radius: 12, y: 6)
    }
}

/// Heart toggle backed by the shared FavoritesStore.
struct FavoriteButton: View {
    @Environment(FavoritesStore.self) private var favorites
    let recipe: Recipe
    var compact = false

    private var isFavorite: Bool {
        favorites.isFavorite(recipe)
    }

    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.35, bounce: 0.45)) {
                favorites.toggle(recipe)
            }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(compact ? .footnote.weight(.semibold) : .body.weight(.semibold))
                .foregroundStyle(isFavorite ? MatchaTheme.rose : MatchaTheme.matchaDeep)
                .padding(compact ? 7 : 10)
                .background(MatchaTheme.cream, in: Circle())
                .contentTransition(.symbolEffect(.replace))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
        .sensoryFeedback(.selection, trigger: isFavorite)
    }
}

#Preview {
    VStack(spacing: 20) {
        RecipeCardView(recipe: RecipeLibrary.all[0])
            .frame(width: 180)
        RecipeRowView(recipe: RecipeLibrary.all[1])
    }
    .padding()
    .background(MatchaTheme.cream)
    .environment(FavoritesStore())
}
