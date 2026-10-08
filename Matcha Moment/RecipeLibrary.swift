import Foundation

/// The bundled recipe collection plus helpers for picking a featured or random recipe.
enum RecipeLibrary {
    /// The recipe featured on the home screen. Rotates once per day so the pick stays stable while the app is open.
    static func featuredRecipe(for date: Date) -> Recipe {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 1
        return all[dayOfYear % all.count]
    }

    /// A random recipe, avoiding the one that was just shown so "Surprise Me" always feels new.
    static func randomRecipe(excluding excluded: Recipe?) -> Recipe {
        let candidates = all.filter { $0.id != excluded?.id }
        return candidates.randomElement() ?? all[0]
    }

    static let all: [Recipe] = [
        Recipe(
            id: "traditional-usucha",
            name: "Traditional Usucha",
            tagline: "The ceremonial thin tea, whisked to a fine foam.",
            description: "Usucha is the simplest and purest way to enjoy matcha: just powder, warm water, and a bamboo whisk. Good technique rewards you with a smooth, grassy bowl topped with delicate foam.",
            prepMinutes: 5,
            restTime: nil,
            servings: 1,
            difficulty: .easy,
            temperature: .hot,
            symbolName: "cup.and.saucer.fill",
            palette: .ceremonial,
            ingredients: [
                "2 g ceremonial-grade matcha (about 2 bamboo scoops or 1 heaping teaspoon)",
                "70 ml filtered water, heated to 80°C (175°F)",
                "A splash of extra hot water for warming the bowl",
            ],
            steps: [
                "Pour a little hot water into your bowl (chawan) and rest the whisk tines in it for 30 seconds to warm the bowl and soften the bamboo. Discard the water and dry the bowl.",
                "Sift the matcha into the bowl through a fine mesh strainer to break up any clumps.",
                "Add a tablespoon of the 80°C water and work it into a smooth, glossy paste with the whisk.",
                "Pour in the remaining water. Hold the bowl steady with one hand and whisk briskly in a W or M motion from the wrist for 15 to 20 seconds, keeping the whisk off the bottom of the bowl.",
                "Once a layer of fine foam covers the surface, slow down and skim the whisk across the top to pop any large bubbles.",
                "Lift the whisk straight out from the center and enjoy immediately.",
            ],
            tip: "Water that is too hot scorches matcha and makes it bitter. If you don't have a thermometer, let freshly boiled water sit for about three minutes."
        ),
        Recipe(
            id: "iced-matcha-latte",
            name: "Iced Matcha Latte",
            tagline: "Cold, creamy, and ready in five minutes.",
            description: "The café classic made at home. Shaking the matcha before it hits the milk keeps the drink smooth and clump-free, with beautiful green and white layers.",
            prepMinutes: 5,
            restTime: nil,
            servings: 1,
            difficulty: .easy,
            temperature: .iced,
            symbolName: "takeoutbag.and.cup.and.straw.fill",
            palette: .iced,
            ingredients: [
                "1½ teaspoons culinary or ceremonial matcha",
                "60 ml warm water (about 75°C / 165°F)",
                "1 to 2 teaspoons maple syrup or simple syrup, to taste",
                "200 ml milk of choice (whole, oat, or almond)",
                "1 cup ice",
            ],
            steps: [
                "Sift the matcha into a small bowl or jar.",
                "Add the warm water and whisk (or seal the jar and shake) until completely smooth and slightly frothy.",
                "Stir the sweetener into the matcha while it is still warm so it dissolves fully.",
                "Fill a tall glass with ice and pour in the milk.",
                "Slowly pour the matcha over the milk to create layers, then stir gently before sipping.",
            ],
            tip: "For the prettiest layers, pour the matcha over the back of a spoon held just above the milk."
        ),
        Recipe(
            id: "honey-oat-matcha-latte",
            name: "Honey Oat Matcha Latte",
            tagline: "A cozy hot latte with naturally sweet oat milk.",
            description: "Oat milk froths beautifully and its gentle sweetness rounds out matcha's grassy edge. A touch of honey and a pinch of cinnamon make this the perfect slow-morning drink.",
            prepMinutes: 8,
            restTime: nil,
            servings: 1,
            difficulty: .easy,
            temperature: .hot,
            symbolName: "mug.fill",
            palette: .oat,
            ingredients: [
                "1½ teaspoons matcha",
                "50 ml hot water (80°C / 175°F)",
                "220 ml barista-style oat milk",
                "1 to 2 teaspoons honey",
                "Pinch of ground cinnamon",
                "Tiny pinch of flaky sea salt (optional)",
            ],
            steps: [
                "Sift the matcha into your mug and add the hot water. Whisk until smooth and frothy.",
                "Stir in the honey and a pinch of salt while the matcha is hot.",
                "Warm the oat milk in a small saucepan or microwave until steaming but not boiling, about 65°C (150°F).",
                "Froth the milk with a handheld frother or by shaking it hard in a sealed heatproof jar for 30 seconds.",
                "Pour the frothed milk over the matcha, holding back the foam with a spoon, then spoon the foam on top.",
                "Dust with cinnamon and serve right away.",
            ],
            tip: "Barista-style oat milk contains a little extra fat, which is what makes the foam glossy and stable."
        ),
        Recipe(
            id: "strawberry-matcha-latte",
            name: "Strawberry Matcha Latte",
            tagline: "Jammy strawberries layered under creamy green.",
            description: "A quick stovetop strawberry purée sits at the bottom of the glass, followed by cold milk and a cloud of matcha. It tastes like spring and looks like a sunset in reverse.",
            prepMinutes: 15,
            restTime: "Cool purée 10 min",
            servings: 2,
            difficulty: .medium,
            temperature: .iced,
            symbolName: "heart.fill",
            palette: .berry,
            ingredients: [
                "200 g fresh or frozen strawberries, hulled and halved",
                "2 tablespoons sugar",
                "1 teaspoon lemon juice",
                "2 teaspoons matcha",
                "100 ml warm water (75°C / 165°F)",
                "350 ml cold milk of choice",
                "Ice, to serve",
            ],
            steps: [
                "Combine the strawberries, sugar, and lemon juice in a small saucepan over medium heat. Cook, stirring and mashing with a fork, for 6 to 8 minutes until jammy and glossy.",
                "Remove from the heat and let the purée cool for about 10 minutes. It will thicken as it cools.",
                "Meanwhile, sift the matcha into a bowl, add the warm water, and whisk until smooth and foamy.",
                "Divide the strawberry purée between two tall glasses and fill each with ice.",
                "Pour the cold milk over the ice, leaving room at the top.",
                "Slowly pour the matcha over each glass so it floats on the milk. Swirl with a straw just before drinking.",
            ],
            tip: "Leftover purée keeps in the fridge for up to five days and is excellent stirred into yogurt."
        ),
        Recipe(
            id: "sparkling-yuzu-matcha",
            name: "Sparkling Yuzu Matcha",
            tagline: "Bright, fizzy, and endlessly refreshing.",
            description: "Matcha meets citrus in this sparkling cooler. Yuzu adds a floral tartness that makes the tea taste brighter, while a honey syrup keeps everything balanced.",
            prepMinutes: 10,
            restTime: nil,
            servings: 2,
            difficulty: .easy,
            temperature: .iced,
            symbolName: "sun.max.fill",
            palette: .citrus,
            ingredients: [
                "2 teaspoons matcha",
                "80 ml warm water (75°C / 165°F)",
                "2 tablespoons honey",
                "2 tablespoons hot water (for the honey syrup)",
                "3 tablespoons yuzu juice (or 2 tablespoons fresh lemon juice)",
                "400 ml chilled sparkling water",
                "Ice, lemon wheels, and fresh mint, to serve",
            ],
            steps: [
                "Stir the honey into the 2 tablespoons of hot water until it dissolves into a thin syrup. Set aside.",
                "Sift the matcha into a bowl, add the warm water, and whisk until smooth with no lumps.",
                "Stir the honey syrup and yuzu juice into the matcha.",
                "Fill two tall glasses with ice and divide the matcha mixture between them.",
                "Top each glass slowly with sparkling water, tilting the glass to preserve the bubbles.",
                "Garnish with a lemon wheel and a sprig of mint, give one gentle stir, and serve.",
            ],
            tip: "Add the sparkling water last and pour slowly; stirring too hard knocks out the fizz."
        ),
        Recipe(
            id: "matcha-chia-pudding",
            name: "Matcha Chia Pudding",
            tagline: "A make-ahead breakfast that sets overnight.",
            description: "Creamy, lightly sweet, and packed with fiber, this chia pudding turns a scoop of matcha into a grab-and-go breakfast. Make it the night before and wake up to something green and good.",
            prepMinutes: 10,
            restTime: "Chill 4 hours or overnight",
            servings: 2,
            difficulty: .easy,
            temperature: .chilled,
            symbolName: "moon.stars.fill",
            palette: .midnight,
            ingredients: [
                "1½ teaspoons matcha",
                "300 ml milk of choice (coconut or oat work well)",
                "2 tablespoons maple syrup",
                "½ teaspoon vanilla extract",
                "Pinch of salt",
                "4 tablespoons chia seeds",
                "Sliced banana, kiwi, toasted coconut, or berries, to serve",
            ],
            steps: [
                "Add the matcha to a jar with 60 ml of the milk. Seal and shake vigorously until no lumps remain.",
                "Pour in the remaining milk, maple syrup, vanilla, and salt. Shake or whisk to combine.",
                "Stir in the chia seeds, making sure none clump at the bottom.",
                "Let the mixture sit for 10 minutes, then stir again to redistribute the seeds.",
                "Cover and refrigerate for at least 4 hours, or overnight, until thick and spoonable.",
                "Divide between two bowls or jars, then top with fruit and toasted coconut before serving.",
            ],
            tip: "If the pudding is thicker than you like in the morning, loosen it with a splash of milk."
        ),
    ]
}
