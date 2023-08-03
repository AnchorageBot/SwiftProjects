//
//  ContentView.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 8/2/2023
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
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
