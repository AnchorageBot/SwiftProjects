//
// Cubic_v3
// ContentView.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

// Main view containing the dice and controls
struct ContentView: View {
    // State properties to track app state
    @State private var diceResult = 1 // Current dice value (1-6)
    @State private var isRolling = false // Whether dice is currently rolling
    @State private var rotationAngle = 0.0 // Current rotation angle
    
    // Define the main view
    var body: some View {
        VStack {
            // App title
            Text("Cubic Dice")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 30)
            
            Spacer()
            
            // Dice container with 3D dice view
            ZStack {
                // Our improved 3D dice view
                ImprovedDiceView(value: diceResult)
                    .frame(width: 200, height: 200)
                    // Apply 3D rotation effect
                    .rotation3DEffect(
                        .degrees(rotationAngle),
                        axis: (
                            x: Double.random(in: 0.3...1.0),
                            y: Double.random(in: 0.3...1.0),
                            z: Double.random(in: 0.1...0.5)
                        ),
                        anchor: .center
                    )
            }
            .frame(height: 250)
            
            // Display the current result
            Text("Result: \(diceResult)")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.vertical, 30)
            
            Spacer()
            
            // Roll button
            Button(action: rollDice) {
                Text("Roll Dice")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(isRolling ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .disabled(isRolling) // Disable during animation
            .padding(.bottom, 40)
        }
        .padding()
    }
    
    // Function to handle dice rolling
    func rollDice() {
        // Prevent multiple rolls
        guard !isRolling else { return }
        
        // Set rolling state
        isRolling = true
        
        // Animate dice rotation
        withAnimation(
            .interpolatingSpring(
                stiffness: 80,
                damping: 8,
                initialVelocity: 1.0
            )
            .speed(0.7)
        ) {
            // Add multiple full rotations (random amount)
            rotationAngle += Double.random(in: 720...1440)
        }
        
        // Configure roll animation
        let rollDuration = 1.8 // Animation duration
        let changeInterval = 0.2 // How often to change value
        var timeElapsed = 0.0 // Track elapsed time
        
        // Timer to update dice value during animation
        Timer.scheduledTimer(withTimeInterval: changeInterval, repeats: true) { timer in
            // Update elapsed time
            timeElapsed += changeInterval
            
            // Randomly change value during animation
            self.diceResult = Int.random(in: 1...6)
            
            // Check if animation should end
            if timeElapsed >= rollDuration {
                // Stop the timer
                timer.invalidate()
                
                // Set final random result
                self.diceResult = Int.random(in: 1...6)
                
                // Reset rolling state
                self.isRolling = false
            }
        }
    }
}
