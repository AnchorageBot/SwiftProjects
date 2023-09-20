/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

struct RecipeListView: View {

    @Binding var selection: Recipe.ID?

    let selectedSidebarItem: SidebarItem

    @EnvironmentObject private var recipeBox: RecipeBox
    
    var body: some View {

        List(recipes, selection: $selection) { recipe in
            NavigationLink(value: recipe.id) {
                RecipeListItemView(recipe: recipe)
            }
            .swipeActions(allowsFullSwipe: false) {
                Button(role: .destructive) {
                    withAnimation {
                        recipeBox.delete(recipe)
                    }
                } label: {
                    Image(systemName: "trash")
                }
                Button {
                    recipeBox.toggleIsFavorite(recipe)
                } label: {
                    Image(systemName: "heart")
                }
            }
        }
    }
    
    private var recipes: [Recipe] {

        switch selectedSidebarItem {

        case .all:
            return recipeBox.allRecipes

        case .favorites:
            return recipeBox.favoriteRecipes()

        case .recents:
            return recipeBox.recentRecipes()

        case .collection(let name):
            return recipeBox.recipesInCollection(name)

        }
    }
}
