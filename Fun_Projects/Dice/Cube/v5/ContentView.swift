//
// Cubic_v5
// ContentView.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI
import CoreHaptics

// The main view containing the dice UI and controls
struct ContentView: View {
    // State variables to track the dice state
    @State private var diceResult = 1 // Current dice value (1-6)
    @State private var isRolling = false // Whether dice is currently rolling
    @State private var rotationX = 0.0 // X-axis rotation angle
    @State private var rotationY = 0.0 // Y-axis rotation angle
    @State private var rotationZ = 0.0 // Z-axis rotation angle
    @State private var rollHistory: [Int] = [] // Store history of dice rolls
    @State private var showHistory = false // Toggle history visibility
    
    // Haptic engine for tactile feedback
    @State private var hapticEngine: CHHapticEngine?
    
    // Environment object for audio playback
    @EnvironmentObject var audioManager: AudioManager
    
    // Setup haptics on appear
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
        }
    }
    
    // Execute a haptic pattern
    func executeHapticPattern() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine = hapticEngine else { return }
        
        // Create a pattern of haptic events for dice roll
        var events = [CHHapticEvent]()
        
        // Add initial impact
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
        
        // Strong initial tap
        let initialEvent = CHHapticEvent(eventType: .hapticTransient,
                                        parameters: [intensity, sharpness],
                                        relativeTime: 0)
        events.append(initialEvent)
        
        // Several smaller bounces/taps with diminishing intensity
        for i in 1...5 {
            let bouncePower = 1.0 - Double(i) * 0.15 // Decreasing intensity
            let bounceIntensity = CHHapticEventParameter(parameterID: .hapticIntensity,
                                                       value: Float(bouncePower))
            let bounceSharpness = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                       value: Float(0.5 - Double(i) * 0.1))
            
            let bounceEvent = CHHapticEvent(eventType: .hapticTransient,
                                           parameters: [bounceIntensity, bounceSharpness],
                                           relativeTime: Double(i) * 0.1)
            events.append(bounceEvent)
        }
        
        // Final strong impact for the result
        let finalIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)
        let finalSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
        let finalEvent = CHHapticEvent(eventType: .hapticTransient,
                                      parameters: [finalIntensity, finalSharpness],
                                      relativeTime: 1.0)
        events.append(finalEvent)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
    
    // Body defines the view content and layout
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.3, alpha: 1)), Color(#colorLiteral(red: 0.1, green: 0.1, blue: 0.2, alpha: 1))]),
                          startPoint: .top,
                          endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Title with improved styling
                Text("Cubic Dice")
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 1, y: 1)
                
                // Dice container with improved shadows and visual effects
                ZStack {
                    // Slight glow behind dice
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 220, height: 220)
                        .blur(radius: 15)
                    
                    // Our refined 3D dice implementation
                    EnhancedCubeView(value: diceResult)
                        .frame(width: 200, height: 200)
                        // Apply sequential 3D rotations on each axis
                        .rotation3DEffect(.degrees(rotationX), axis: (x: 1, y: 0, z: 0))
                        .rotation3DEffect(.degrees(rotationY), axis: (x: 0, y: 1, z: 0))
                        .rotation3DEffect(.degrees(rotationZ), axis: (x: 0, y: 0, z: 1))
                }
                .frame(height: 250)
                
                // Result display with improved styling
                Text("Result: \(diceResult)")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)
                
                // Roll history section
                if showHistory {
                    VStack(spacing: 10) {
                        Text("Roll History")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(rollHistory.indices.reversed(), id: \.self) { index in
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text("\(rollHistory[index])")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.blue)
                                        )
                                        .shadow(color: Color.black.opacity(0.3), radius: 2)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.2))
                        )
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 10)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                // Buttons row
                HStack(spacing: 20) {
                    // Roll button with visual feedback
                    Button(action: rollDice) {
                        Text("Roll Dice")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 150)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                isRolling ? Color.gray : Color.blue,
                                                isRolling ? Color.gray.opacity(0.7) : Color.blue.opacity(0.7)
                                            ]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 2)
                            )
                    }
                    .disabled(isRolling) // Disable during animation
                    
                    // History toggle button
                    Button(action: {
                        withAnimation(.spring()) {
                            showHistory.toggle()
                        }
                    }) {
                        Image(systemName: showHistory ? "clock.fill" : "clock")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(Color.blue.opacity(0.7))
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 2)
                            )
                    }
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
        .onAppear {
            prepareHaptics() // Setup haptics when view appears
        }
    }
    
    // Function to handle dice rolling logic
    func rollDice() {
        // Prevent multiple simultaneous rolls
        guard !isRolling else { return }
        
        // Set rolling state to true
        isRolling = true
        
        // Play dice rolling sound
        audioManager.playSound(sound: "dice_roll")
        
        // Trigger haptic feedback
        executeHapticPattern()
        
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
        let changeInterval = 0.1 // How often to change the value during animation
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
                let finalResult = Int.random(in: 1...6)
                self.diceResult = finalResult
                
                // Add to roll history
                self.rollHistory.append(finalResult)
                
                // Limit history to last 10 rolls
                if self.rollHistory.count > 10 {
                    self.rollHistory.removeFirst(self.rollHistory.count - 10)
                }
                
                // Play dice landing sound
                audioManager.playSound(sound: "dice_land")
                
                // Reset rolling state to enable button
                self.isRolling = false
            }
        }
    }
}
