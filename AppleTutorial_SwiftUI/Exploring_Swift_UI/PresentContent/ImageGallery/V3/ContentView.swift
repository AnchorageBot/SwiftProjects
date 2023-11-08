/*

 ContentView.swift
 Explore_SwiftUI_V7

 How to create this project with Xcode commands:

   * Xcode-> File-> New Project -> iOS - App

 This creates two files

   * ContentView.swift
   * ProjectName_App.swift

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uitableviewcell/1623229-contentview

 https://developer.apple.com/documentation/swiftui/navigationstack

 Created on 11/2/2023 and updated on 11/7/2023 with Swift 5.9, Xcode 15.0

 Contains the initial user interface (UI) for your app

*/

import SwiftUI

struct ContentView: View {

    @StateObject var dataModel = DataModel()

    var body: some View {

        NavigationStack {

                       GridView()

                   }
        
                   .environmentObject(dataModel)
                   .navigationViewStyle(.stack)

        }
        //.padding()
    }

#Preview {

    ContentView()
}
