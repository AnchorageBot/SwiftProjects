/*

 ContentListView.swift
 LearnSwiftUI_V6

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> iOS -> SwiftUI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/17/2023
 Made with Swift 5.8, Xcode 14.3.1

 ContentListView is a custom view that conforms to the View protocol and displays a list of recipes

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
