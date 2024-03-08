//
//  Drafts Group
//  NavView.swift
//  StrawberryBot_V1
//
//  Created by Claude and ATS on 3/7/24
//  Placeholder for tracking draft code

import SwiftUI

struct NavView: View {
    // State variable to control the presentation of ContentView
    @State private var isShowingContentView = false

    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // NavigationLink to navigate to ContentView
                NavigationLink(
                    destination: ContentView(), // The view to navigate to
                    isActive: $isShowingContentView // Binding to control the navigation
                ) {
                    // Button to trigger the navigation
                    Button {
                        isShowingContentView.toggle() // Toggle the state variable when tapped
                    } label: {
                        Image(systemName: "house.circle.fill") // Button image
                    }
                }
            }
        }
    }
}

// Preview for NavView
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
