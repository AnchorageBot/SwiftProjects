//
//  ContextView.swift
//  MonteCarloPi
//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file defines the ContextView, which provides additional information and context
// about the Monte Carlo method for estimating Pi. It includes an explanation of the
// algorithm and its mathematical basis, enhancing the educational value of the app.

import SwiftUI

// SwiftUI view to display context information about the Monte Carlo Pi estimation
struct ContextView: View {
    var body: some View {
        // Use ScrollView to allow scrolling if content exceeds screen size
        ScrollView {
            // Arrange content in a vertical stack
            VStack(alignment: .leading, spacing: 15) {
                // Title of the context view
                Text("Monte Carlo Method for Estimating Pi")
                    .font(.title2)
                    .fontWeight(.bold)
                
                // Brief introduction to the Monte Carlo method
                Text("The Monte Carlo method for estimating Pi is a statistical technique that uses random sampling to approximate the value of Pi.")
                    .font(.subheadline)
                
                // Section header for how the method works
                Text("How it works:")
                    .font(.headline)
                
                // Step-by-step explanation of the Monte Carlo method
                Group {
                    Text("1. We consider a square with side length 1, inscribed with a quarter circle of radius 1.")
                    Text("2. We randomly generate points within the square.")
                    Text("3. We count how many points fall inside the quarter circle.")
                    Text("4. The ratio of points inside the circle to total points, multiplied by 4, approximates Pi.")
                }
                .font(.subheadline)
                
                // Section header for mathematical basis
                Text("Mathematical basis:")
                    .font(.headline)
                
                // Mathematical explanation of the method
                Group {
                    Text("Area of the square: 1 x 1 = 1")
                    Text("Area of the quarter circle: πr² / 4 = π / 4 (since r = 1)")
                    Text("Ratio of areas: (π / 4) / 1 = π / 4")
                }
                .font(.subheadline)
                
                // Note on accuracy
                Text("As we increase the number of points, our estimate becomes more accurate.")
                    .font(.subheadline)
                    .italic()
            }
            .padding()
        }
    }
}

// Preview provider for ContextView
struct ContextView_Previews: PreviewProvider {
    static var previews: some View {
        ContextView()
    }
}
