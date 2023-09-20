/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

@main

struct RecipesSampleApp: App {

    @StateObject private var recipeBox = RecipeBox(recipes: load("recipeData.json"))
    @State private var selectedSidebarItem: SidebarItem? = SidebarItem.all
    @State private var selectedRecipeId: Recipe.ID?

    var body: some Scene {

        WindowGroup {

            NavigationSplitView {

                SidebarView(selection: $selectedSidebarItem, recipeBox: recipeBox)

            } content: {
                ContentListView(selection: $selectedRecipeId, selectedSidebarItem: selectedSidebarItem ?? SidebarItem.all)

            } detail: {
                DetailView(recipeId: $selectedRecipeId)
            }
            .environmentObject(recipeBox)
        }
    }
}
