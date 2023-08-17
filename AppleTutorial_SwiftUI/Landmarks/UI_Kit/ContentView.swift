//
//  ContentView.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 8/7/2023
//  Ref: https //developer.apple.com/tutorials/swiftui
//
//  Xcode->File->New->Project
//  Template->iOS->App
//  Product Name->Landmarks
//  Interface->SwiftUI
//  Language->Swift
//
//  Editor->Canvas
//  Content View->Selectable->Show SwiftUI Inspector

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
        }
                .tag(Tab.featured)
            
            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
            }
            .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
