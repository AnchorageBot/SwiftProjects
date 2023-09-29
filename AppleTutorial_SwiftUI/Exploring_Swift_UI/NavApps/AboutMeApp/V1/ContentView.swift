/*

 ContentView.swift
 Explore_SwiftUI_V1

 How to create this project with Xcode commands:

    * Xcode-> File-> New Project -> iOS - App

 This creates two files

    * ContentView.swift
    * ProjectName_App.swift

 References:

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/View/body-8kl5o

 https://developer.apple.com/documentation/SwiftUI/TabView

 https://developer.apple.com/documentation/SwiftUI/Label

 Created on 9/27/2023 with Swift 5.9, Xcode 15.0
 Updated on 9/28/2023

*/

import SwiftUI

struct ContentView: View {

    // The content and behavior of the view
    var body: some View {

        // Creates a user interface with tabs
        TabView {

            HomeView()
                .tabItem {
                    Label("Home", systemImage: "person")
                        //.preferredColorScheme(.dark)
                }

            StoryView()
                .tabItem {
                    Label("Story", systemImage: "book")
                        //.preferredColorScheme(.dark)
                }


            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                        //.preferredColorScheme(.dark)
                }

            FunFactsView()
                .tabItem {
                    Label("Fun Facts", systemImage: "dice")
                        //.preferredColorScheme(.dark)
                }


            //.preferredColorScheme(.dark)

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
