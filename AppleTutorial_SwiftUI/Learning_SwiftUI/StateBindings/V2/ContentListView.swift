/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

struct ContentListView: View {

    @Binding var selection: Recipe.ID?

    let selectedSidebarItem: SidebarItem

    @EnvironmentObject private var recipeBox: RecipeBox
    @State private var recipeEditorConfig = RecipeEditorConfig()

    var body: some View {

        RecipeListView(selection: $selection, selectedSidebarItem: selectedSidebarItem)
            .navigationTitle(selectedSidebarItem.title)
            .toolbar {

                ToolbarItem {

                    Button {
                        recipeEditorConfig.presentAddRecipe(sidebarItem: selectedSidebarItem)

                    } label: {
                        Image(systemName: "plus")

                    }
                    .sheet(isPresented: $recipeEditorConfig.isPresented,
                           onDismiss: didDismissEditor) {
                        RecipeEditor(config: $recipeEditorConfig)
                    }
                }
            }
    }
    
    private func didDismissEditor() {

        if recipeEditorConfig.shouldSaveChanges {

            if recipeEditorConfig.recipe.isNew {

                selection = recipeBox.add(recipeEditorConfig.recipe)

            } else {

                recipeBox.update(recipeEditorConfig.recipe)

            }
        }
    }
}
