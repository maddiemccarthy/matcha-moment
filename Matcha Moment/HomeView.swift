import SwiftUI

/// Landing screen: greeting, today's featured recipe, the Surprise Me button, and the full recipe grid.
struct HomeView: View {
    @State private var surpriseRecipe: Recipe?
    @State private var surpriseCount = 0

    private let featuredRecipe = RecipeLibrary.featuredRecipe(for: .now)
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    greeting
                    featuredSection
                    surpriseButton
                    allRecipesSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
            .background(MatchaTheme.cream.ignoresSafeArea())
            .navigationTitle("Matcha Moment")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .sheet(item: $surpriseRecipe) { recipe in
                NavigationStack {
                    RecipeDetailView(recipe: recipe)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Done") {
                                    surpriseRecipe = nil
                                }
                            }
                        }
                }
                .tint(MatchaTheme.matchaDeep)
                .presentationDragIndicator(.visible)
            }
            .sensoryFeedback(.impact(weight: .medium), trigger: surpriseCount)
        }
    }

    // MARK: Sections

    private var greeting: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(greetingTitle)
                .font(.title2.weight(.semibold))
                .foregroundStyle(MatchaTheme.ink)
            Text("Slow down, whisk, and savor something green.")
                .font(.subheadline)
                .foregroundStyle(MatchaTheme.inkSoft)
        }
    }

    private var greetingTitle: String {
        let hour = Calendar.current.component(.hour, from: .now)
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Featured today", subtitle: "A fresh pick every day")
            NavigationLink(value: featuredRecipe) {
                FeaturedRecipeCard(recipe: featuredRecipe)
            }
            .buttonStyle(PressableButtonStyle())
        }
    }

    private var surpriseButton: some View {
        Button {
            surprise()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "sparkles")
                Text("Surprise Me")
            }
            .font(.headline)
            .foregroundStyle(MatchaTheme.cream)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(MatchaTheme.matchaDeep, in: Capsule())
            .shadow(color: MatchaTheme.matchaDeep.opacity(0.25), radius: 12, y: 6)
        }
        .buttonStyle(PressableButtonStyle())
        .accessibilityHint("Opens a random matcha recipe")
    }

    private var allRecipesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "All recipes", subtitle: "\(RecipeLibrary.all.count) ways to enjoy matcha")
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(RecipeLibrary.all) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeCardView(recipe: recipe)
                    }
                    .buttonStyle(PressableButtonStyle())
                }
            }
        }
    }

    // MARK: Actions

    private func surprise() {
        surpriseCount += 1
        surpriseRecipe = RecipeLibrary.randomRecipe(excluding: surpriseRecipe)
    }
}

/// Large hero card used for the featured recipe.
struct FeaturedRecipeCard: View {
    let recipe: Recipe

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            recipe.palette.gradient

            Image(systemName: recipe.symbolName)
                .font(.system(size: 150, weight: .bold))
                .foregroundStyle(.white.opacity(0.16))
                .rotationEffect(.degrees(-12))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .offset(x: 24, y: -20)

            VStack(alignment: .leading, spacing: 10) {
                Text("FEATURED")
                    .font(.caption2.weight(.bold))
                    .tracking(1.5)
                    .foregroundStyle(MatchaTheme.matchaDeep)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(MatchaTheme.cream, in: Capsule())

                Text(recipe.name)
                    .font(.title.weight(.bold))
                    .foregroundStyle(.white)

                Text(recipe.tagline)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(2)

                HStack(spacing: 8) {
                    InfoChip(text: recipe.prepTimeText, symbolName: "clock")
                    InfoChip(text: recipe.servingsText, symbolName: "person.2")
                    InfoChip(text: recipe.difficulty.rawValue, symbolName: "chart.bar")
                }
            }
            .padding(22)
        }
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: MatchaTheme.heroCornerRadius, style: .continuous))
        .shadow(color: MatchaTheme.matchaDeep.opacity(0.22), radius: 18, y: 10)
        .accessibilityElement(children: .combine)
    }
}

/// Small translucent capsule used over gradient backgrounds.
struct InfoChip: View {
    let text: String
    let symbolName: String

    var body: some View {
        Label(text, systemImage: symbolName)
            .font(.caption.weight(.medium))
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.white.opacity(0.22), in: Capsule())
    }
}

#Preview {
    HomeView()
        .environment(FavoritesStore())
}
