//
// Cubic_v4
// ContentView.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

// The main view containing the dice UI and controls
struct ContentView: View {
    // State variables to track the dice state
    @State private var diceResult = 1 // Current dice value (1-6)
    @State private var isRolling = false // Whether dice is currently rolling
    @State private var rotationX = 0.0 // X-axis rotation angle
    @State private var rotationY = 0.0 // Y-axis rotation angle
    @State private var rotationZ = 0.0 // Z-axis rotation angle
    
    // Body defines the view content and layout
    var body: some View {
        VStack {
            // Title
            Text("Cubic Dice")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 30)
            
            Spacer()
            
            // Dice view container
            ZStack {
                // Our refined 3D dice implementation
                CubeView(value: diceResult)
                    .frame(width: 200, height: 200)
                    // Apply sequential 3D rotations on each axis
                    .rotation3DEffect(.degrees(rotationX), axis: (x: 1, y: 0, z: 0))
                    .rotation3DEffect(.degrees(rotationY), axis: (x: 0, y: 1, z: 0))
                    .rotation3DEffect(.degrees(rotationZ), axis: (x: 0, y: 0, z: 1))
            }
            .frame(height: 250)
            
            // Result display
            Text("Result: \(diceResult)")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.vertical, 20)
            
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
    
    // Function to handle dice rolling logic
    func rollDice() {
        // Prevent multiple simultaneous rolls
        guard !isRolling else { return }
        
        // Set rolling state to true
        isRolling = true
        
        // Generate random rotation end values for realistic tumbling
        let targetX = Double.random(in: 360...720) * (Bool.random() ? 1 : -1)
        let targetY = Double.random(in: 360...720) * (Bool.random() ? 1 : -1)
        let targetZ = Double.random(in: 180...360) * (Bool.random() ? 1 : -1)
        
        // Animate the rotation with a spring effect for realistic physics
        withAnimation(
            .interpolatingSpring(
                stiffness: 50,
                damping: 8,
                initialVelocity: 5
            )
            .speed(0.7)
        ) {
            // Apply the rotation targets
            rotationX += targetX
            rotationY += targetY
            rotationZ += targetZ
        }
        
        // Configure roll animation parameters
        let rollDuration = 2.0 // Total animation time in seconds
        let changeInterval = 0.15 // How often to change the value during animation
        var timeElapsed = 0.0 // Track elapsed time
        
        // Create a timer to update the dice value during animation
        Timer.scheduledTimer(withTimeInterval: changeInterval, repeats: true) { timer in
            // Increment elapsed time
            timeElapsed += changeInterval
            
            // Rapidly change dice value during animation for visual effect
            self.diceResult = Int.random(in: 1...6)
            
            // Check if animation should end
            if timeElapsed >= rollDuration {
                // Stop the timer
                timer.invalidate()
                
                // Set final random result
                self.diceResult = Int.random(in: 1...6)
                
                // Reset rolling state to enable button
                self.isRolling = false
            }
        }
    }
}
