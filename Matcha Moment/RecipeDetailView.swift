import SwiftUI

/// Full recipe: hero, description, quick stats, ingredients, numbered steps, and a tip.
struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                hero
                titleBlock
                statsRow
                ingredientsSection
                stepsSection
                if let tip = recipe.tip {
                    tipCard(tip)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 40)
        }
        .background(MatchaTheme.cream.ignoresSafeArea())
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                FavoriteButton(recipe: recipe)
            }
        }
    }

    // MARK: Hero

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            recipe.palette.gradient

            Image(systemName: recipe.symbolName)
                .font(.system(size: 96, weight: .medium))
                .foregroundStyle(.white.opacity(0.95))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(color: .black.opacity(0.12), radius: 10, y: 6)

            InfoChip(text: "Served \(recipe.temperature.label.lowercased())", symbolName: recipe.temperature.symbolName)
                .padding(16)
        }
        .frame(height: 230)
        .clipShape(RoundedRectangle(cornerRadius: MatchaTheme.heroCornerRadius, style: .continuous))
        .shadow(color: MatchaTheme.matchaDeep.opacity(0.2), radius: 18, y: 10)
        .accessibilityHidden(true)
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(recipe.name)
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(MatchaTheme.ink)
            Text(recipe.tagline)
                .font(.headline)
                .foregroundStyle(MatchaTheme.matchaDeep)
            Text(recipe.description)
                .font(.body)
                .foregroundStyle(MatchaTheme.inkSoft)
                .padding(.top, 4)
        }
    }

    // MARK: Stats

    private var statsRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                StatTile(title: "Prep time", value: recipe.prepTimeText, symbolName: "clock.fill")
                StatTile(title: "Serves", value: "\(recipe.servings)", symbolName: "person.2.fill")
                StatTile(title: "Difficulty", value: recipe.difficulty.rawValue, symbolName: "chart.bar.fill")
            }
            if let restTime = recipe.restTime {
                Label(restTime, systemImage: "hourglass")
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(MatchaTheme.inkSoft)
            }
        }
    }

    // MARK: Ingredients

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Ingredients", subtitle: recipe.servingsText)
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                    HStack(alignment: .firstTextBaseline, spacing: 12) {
                        Image(systemName: "leaf.fill")
                            .font(.caption2)
                            .foregroundStyle(MatchaTheme.matcha)
                        Text(ingredient)
                            .font(.body)
                            .foregroundStyle(MatchaTheme.ink)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 12)

                    if index < recipe.ingredients.count - 1 {
                        Divider()
                            .overlay(MatchaTheme.matchaLight)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 6)
            .background(MatchaTheme.card, in: RoundedRectangle(cornerRadius: MatchaTheme.cardCornerRadius, style: .continuous))
        }
    }

    // MARK: Steps

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Steps", subtitle: "\(recipe.steps.count) steps")
            VStack(alignment: .leading, spacing: 18) {
                ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: 14) {
                        Text("\(index + 1)")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(MatchaTheme.matchaDeep)
                            .frame(width: 32, height: 32)
                            .background(MatchaTheme.matchaLight, in: Circle())
                        Text(step)
                            .font(.body)
                            .foregroundStyle(MatchaTheme.ink)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding(18)
            .background(MatchaTheme.card, in: RoundedRectangle(cornerRadius: MatchaTheme.cardCornerRadius, style: .continuous))
        }
    }

    // MARK: Tip

    private func tipCard(_ tip: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "lightbulb.fill")
                .font(.title3)
                .foregroundStyle(MatchaTheme.matchaDeep)
            VStack(alignment: .leading, spacing: 4) {
                Text("Barista tip")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(MatchaTheme.matchaDeep)
                Text(tip)
                    .font(.footnote)
                    .foregroundStyle(MatchaTheme.ink)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(MatchaTheme.matchaLight.opacity(0.6), in: RoundedRectangle(cornerRadius: MatchaTheme.cardCornerRadius, style: .continuous))
    }
}

/// Compact stat card used in the detail header.
struct StatTile: View {
    let title: String
    let value: String
    let symbolName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: symbolName)
                .font(.footnote)
                .foregroundStyle(MatchaTheme.matcha)
            Text(value)
                .font(.headline)
                .foregroundStyle(MatchaTheme.ink)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Text(title)
                .font(.caption2)
                .foregroundStyle(MatchaTheme.inkSoft)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(MatchaTheme.card, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: RecipeLibrary.all[3])
    }
    .environment(FavoritesStore())
}
