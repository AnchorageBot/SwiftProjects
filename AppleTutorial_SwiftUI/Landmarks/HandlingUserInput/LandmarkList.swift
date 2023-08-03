//
//  LandmarkList.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 8/2/2023
//  Ref: https //developer.apple.com/tutorials/swiftui
//
//  Xcode->File->New->File->SwiftUI View
//  Editor->Canvas
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    // State is a value, or a set of values, that can change over time, and that affects a view’s behavior, content, or layout
    // You use a property with the @State attribute to add state to a view
    @State private var showFavoritesOnly = false
    
    // filtered version of landmarks in list
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                
                // adds a control to toggle the state
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                // transforms the landmarks into rows
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
