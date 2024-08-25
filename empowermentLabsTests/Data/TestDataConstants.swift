//
//  Data.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Foundation
@testable import empowermentLabs

struct TestDataConstants {
    
    static let resultResponse: APIResultResponse = {
        APIResultResponse(results: [
            APIRecipeResponse(
                id: 782585,
                title: "Cannellini Bean and Asparagus Salad with Mushrooms",
                image: "https://spoonacular.com/recipeImages/782585-312x231.jpg",
                imageType: "jpg"
            ),
            APIRecipeResponse(
                id: 716426,
                title: "Cauliflower, Brown Rice, and Vegetable Fried Rice",
                image: "https://spoonacular.com/recipeImages/716426-312x231.jpg",
                imageType: "jpg"
            ),
        ])
    }()
    
    static let recipeDetailResponse: ApiRecipeDetailResponse = {
        ApiRecipeDetailResponse(
            id: 782585,
            title: "Cannellini Bean and Asparagus Salad with Mushrooms",
            readyInMinutes: 45,
            instructions: "Rinse the cannellini beans and soak for 8 hours or overnight in several inches of water. Drain and rinse, then transfer to a medium saucepan and cover with fresh water. Add the curry leaves or bay leaf and bring to a boil. Reduce heat to medium-low, cover, and simmer for 1 hour or until the beans are tender but not falling apart. Drain and transfer to a large salad bowl.Meanwhile, snap the woody ends off of the asparagus spears and steam the spears for 6 minutes or until just tender but still retaining their crunch. Transfer to the salad bowl.Now cook the mushrooms. Heat the oil in a large skillet over high heat. As soon as the oil is hot, drop in the mushrooms and cook, stirring constantly, for 5 minutes or until the mushrooms begin to brown and lose some of their liquid. Transfer to the bowl with the asparagus.To make the dressing, combine the tarragon, lemon zest, garlic, lemon juice, olive oil and mustard in a small food processor or blender. Process until smooth.Pour the dressing over the salad, season with salt and pepper, and toss. Serve at room temperature or chilled.",
            image: "https://spoonacular.com/recipeImages/782585-556x370.jpg",
            extendedIngredients: [
                APIIngredientResponse(
                    id: 10016049,
                    name: "cannellini beans",
                    original: "1 1/4 cups dried cannellini (white kidney) beans (3 3/4 cups cooked)",
                    image: "dry-cannellini-beans.jpg"),
                APIIngredientResponse(
                    id: 93604,
                    name: "curry leaves",
                    original: "handful of dried curry leaves, crumbled (or 1 bay leaf)",
                    image: "curry-leaves.jpg")
            ]
        )
    }()
}
