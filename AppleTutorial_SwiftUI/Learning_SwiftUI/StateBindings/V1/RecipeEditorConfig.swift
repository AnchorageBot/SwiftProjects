/*

 RecipeEditorConfig.swift
 LearnSwiftUI_V6

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> iOS -> Swift File

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/17/2023
 Made with Swift 5.8, Xcode 14.3.1

 The structure RecipeEditorConfig stores the state data that the RecipeEditor view needs

*/

import Foundation

struct RecipeEditorConfig {

    var recipe = Recipe.emptyRecipe()
    var shouldSaveChanges = false
    var isPresented = false

    // To trigger state changes that happen in the RecipeEditor view, RecipeEditorConfig provides mutating functions that update the data to reflect a new state
    mutating func presentAddRecipe(sidebarItem: SidebarItem) {

        recipe = Recipe.emptyRecipe()

        switch sidebarItem {

        case .favorites:
            // Associate the recipe to the favorites collection
            recipe.isFavorite = true

        case .collection(let name):
            // Associate the recipe to a custom collection
            recipe.collections = [name]

        default:
            // Nothing else to do
            break
        }

        // flag is set to false because changes have yet to be saved
        shouldSaveChanges = false
        // flag is set to true to tell SwiftUI to display the editor view
        isPresented = true

    }

    mutating func presentEditRecipe(_ recipeToEdit: Recipe) {
        recipe = recipeToEdit
        shouldSaveChanges = false
        isPresented = true
    }

    mutating func done() {
        shouldSaveChanges = true
        isPresented = false
    }

    mutating func cancel() {
        shouldSaveChanges = false
        isPresented = false
    }

}
