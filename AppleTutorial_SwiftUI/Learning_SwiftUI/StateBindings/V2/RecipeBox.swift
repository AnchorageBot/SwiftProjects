/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

class RecipeBox: ObservableObject {
    @Published var allRecipes: [Recipe]
    @Published var collections: [String]
    
    init(recipes: [Recipe]) {
        self.allRecipes = recipes
        self.collections = RecipeBox.collection(from: recipes)
    }

    func recipesInCollection(_ collectionName: String?) -> [Recipe] {
        if let name = collectionName {
            return allRecipes.filter { $0.collections.contains(name) }
        } else {
            return []
        }
        
    }
    
    func favoriteRecipes() -> [Recipe] {
        return allRecipes.filter { $0.isFavorite }
    }
    
    func recentRecipes(age: Int = 30) -> [Recipe] {
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -age, to: Date()) ?? Date()
        return allRecipes.filter { $0.addedOnDate > thirtyDaysAgo }
    }

    func delete(_ recipe: Recipe) {
        delete(recipe.id)
    }
    
    func delete(_ id: Recipe.ID) {
        if let index = index(for: id) {
            allRecipes.remove(at: index)
            updateCollectionsIfNeeded()
        }
    }
    
    func update(_ recipe: Recipe) {
        if let index = index(for: recipe.id) {
            allRecipes[index] = recipe
            updateCollectionsIfNeeded()
        }
    }
    
    func toggleIsFavorite(_ recipe: Recipe) {
        var recipeToUpdate = recipe
        recipeToUpdate.isFavorite.toggle()
        update(recipeToUpdate)
    }
    
    func index(for id: Recipe.ID) -> Int? {
        allRecipes.firstIndex(where: { $0.id == id })
    }
    
    func recipe(with id: Int) -> Recipe? {
        return allRecipes.first(where: { $0.id == id })
    }
    
    func contains(_ recipe: Recipe) -> Bool {
        contains(recipe.id)
    }

    func contains(_ id: Recipe.ID?) -> Bool {
        guard let recipeId = id else { return false }
        return allRecipes.contains { $0.id == recipeId }
    }
}

extension RecipeBox {
    func add(_ recipe: Recipe) -> Recipe.ID {
        var recipeToAdd = recipe
        // Increment the recipe id.
        recipeToAdd.id = (allRecipes.map { $0.id }.max() ?? 0) + 1
        allRecipes.append(recipeToAdd)
        updateCollectionsIfNeeded()
        return recipeToAdd.id
    }
}

extension RecipeBox {
    fileprivate static func collection(from recipes: [Recipe]) -> [String] {
        var allCollections = Set<String>()
        for recipe in recipes {
            allCollections.formUnion(recipe.collections)
        }
        return allCollections.sorted()
    }

    fileprivate func updateCollectionsIfNeeded() {
        let updatedCollection = RecipeBox.collection(from: allRecipes)
        if collections != updatedCollection {
            collections = updatedCollection
        }
    }
}
