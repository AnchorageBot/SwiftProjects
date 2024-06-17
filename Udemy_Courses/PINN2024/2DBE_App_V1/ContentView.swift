//
//  ContentView.swift
//  2DBE_Example.swift
//
//  Inspired & shaped by Dr. Mohammad Samara's Udemy class on PINN
//  Created by ATS and Claude on 6/16/24
//  Made with Xcode 15.4
//

// Abstract: This file contains the main content view of the app, which displays a tab view with three tabs: Initial Conditions, Final U Velocity, and Final V Velocity. It also creates an instance of the BurgersEquationSimulation class and starts the simulation when the view appears.

import SwiftUI // Import the SwiftUI framework

// Code block: Content view
struct ContentView: View { // Define the content view structure
    @StateObject private var simulation = BurgersEquationSimulation() // Create an instance of the BurgersEquationSimulation class as a state object
    
    var body: some View { // Define the body of the content view
        TabView { // Create a tab view
            InitialConditionsView(simulation: simulation) // Create the Initial Conditions tab
                .tabItem {
                    Label("Initial Conditions", systemImage: "square.grid.2x2") // Set the tab item label and icon
                }
            
            FinalUVelocityView(simulation: simulation, component: .u) // Create the Final U Velocity tab
                .tabItem {
                    Label("Final U Velocity", systemImage: "arrow.right") // Set the tab item label and icon
                }
            
            FinalUVelocityView(simulation: simulation, component: .v) // Create the Final V Velocity tab
                .tabItem {
                    Label("Final V Velocity", systemImage: "arrow.up") // Set the tab item label and icon
                }
        }
        .onAppear {
            simulation.simulate() // Start the simulation when the view appears
        }
    }
}

// Code block: Preview provider
struct ContentView_Previews: PreviewProvider { // Define the preview provider for ContentView
    static var previews: some View { // Define the preview
        ContentView() // Display ContentView in the preview
    }
}
