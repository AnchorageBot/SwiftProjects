//
// Cubic_v7
// ContentView.swift
//
// Created on 5/4/25
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
    @State private var diceScale: CGFloat = 1.0 // Scale for dice animation
    
    // Animation state for smoother transitions
    @State private var animationState = DiceAnimationState()
    
    // Dice appearance settings - using a richer red color
    let diceColor = Color(#colorLiteral(red: 0.85, green: 0.1, blue: 0.1, alpha: 1))
    
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
            // Background with radial gradient for better depth perception
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(#colorLiteral(red: 0.25, green: 0.25, blue: 0.35, alpha: 1)),
                    Color(#colorLiteral(red: 0.12, green: 0.12, blue: 0.18, alpha: 1))
                ]),
                center: .center,
                startRadius: 1,
                endRadius: 400
            )
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
                    // Light glow effect behind dice
                    Circle()
                        .fill(diceColor.opacity(0.15))
                        .frame(width: 220, height: 220)
                        .blur(radius: 20)
                    
                    // Our refined 3D dice implementation with proper artistic perspective
                    ImprovedDiceView(value: diceResult, diceColor: diceColor)
                        .frame(width: 180, height: 180)
                        .scaleEffect(diceScale)
                        // Apply sequential 3D rotations on each axis
                        .rotation3DEffect(.degrees(rotationX), axis: (x: 1, y: 0, z: 0))
                        .rotation3DEffect(.degrees(rotationY), axis: (x: 0, y: 1, z: 0))
                        .rotation3DEffect(.degrees(rotationZ), axis: (x: 0, y: 0, z: 1))
                }
                .frame(height: 250)
                
                // Result display with improved styling
                HStack {
                    Spacer()
                    Text("Result: ")
                        .font(.system(size: 32, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("\(diceResult)")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(minWidth: 35, alignment: .center)
                        .padding(.leading, -5)
                    Spacer()
                }
                .padding(.vertical, 20)
                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)
                
                // Roll history section with improved visuals
                if showHistory {
                    VStack(spacing: 10) {
                        Text("Roll History")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(rollHistory.indices.reversed(), id: \.self) { index in
                                    ZStack {
                                        // Background gradient for history items
                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [
                                                        Color.blue.opacity(0.8),
                                                        Color.blue.opacity(0.6)
                                                    ]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 42, height: 42)
                                            .shadow(color: Color.black.opacity(0.3), radius: 3)
                                        
                                        // Dice result number
                                        Text("\(rollHistory[index])")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .accessibilityLabel("Roll number \(index + 1): \(rollHistory[index])")
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 65)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue.opacity(0.15))
                                .shadow(color: Color.black.opacity(0.2), radius: 2)
                        )
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 10)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                Spacer()
                
                // Buttons row with improved layout
                HStack(spacing: 20) {
                    // Roll button with enhanced visual feedback
                    Button(action: rollDice) {
                        Text("Roll Dice")
                            .font(.system(size: 21, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 30)
                            .background(
                                ZStack {
                                    // Main button gradient
                                    RoundedRectangle(cornerRadius: 18)
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
                                    
                                    // Top highlight
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color.white.opacity(0.2))
                                        .mask(
                                            RoundedRectangle(cornerRadius: 18)
                                                .frame(height: 20)
                                                .offset(y: -13)
                                        )
                                }
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                            .shadow(color: (isRolling ? Color.gray : Color.blue).opacity(0.5),
                                    radius: 8, x: 0, y: 4)
                    }
                    .disabled(isRolling) // Disable during animation
                    .padding(.bottom, 5) // Offset to center with history button
                    
                    // History toggle button with improved visuals
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            showHistory.toggle()
                        }
                    }) {
                        ZStack {
                            // Button gradient background
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.blue.opacity(0.9),
                                            Color.blue.opacity(0.7)
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .overlay(
                                    // Top highlight
                                    Circle()
                                        .fill(Color.white.opacity(0.2))
                                        .mask(
                                            Circle()
                                                .frame(height: 30)
                                                .offset(y: -10)
                                        )
                                )
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 4)
                                .frame(width: 56, height: 56)
                            
                            // Icon
                            Image(systemName: showHistory ? "clock.fill" : "clock")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    .accessibilityLabel(showHistory ? "Hide roll history" : "Show roll history")
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
        .onAppear {
            prepareHaptics() // Setup haptics when view appears
        }
    }
    
    // Function to handle dice rolling logic with enhanced animation
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
        
        // Enhanced animation sequence
        
        // 1. Quick scale down with shake to simulate picking up dice
        withAnimation(.easeIn(duration: 0.2)) {
            diceScale = 0.8
        }
        
        // 2. Main dice rolling animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Animate the rotation with improved spring physics for realistic motion
            withAnimation(
                .interpolatingSpring(
                    stiffness: 40, // Lower stiffness for more bounce
                    damping: 7,    // Lower damping for more oscillation
                    initialVelocity: 7 // Higher initial velocity for more energy
                )
                .speed(0.65) // Slightly slower for more visual interest
            ) {
                // Apply the rotation targets
                rotationX += targetX
                rotationY += targetY
                rotationZ += targetZ
                diceScale = 1.0 // Return to normal size
            }
            
            // Configure roll animation parameters
            let rollDuration = 2.2 // Slightly longer animation time for more drama
            let changeInterval = 0.08 // More frequent changes for smoother animation
            var timeElapsed = 0.0 // Track elapsed time
            
            // Randomly select intermediate outcomes during animation
            // This creates a more exciting build-up to the final result
            Timer.scheduledTimer(withTimeInterval: changeInterval, repeats: true) { timer in
                // Increment elapsed time
                timeElapsed += changeInterval
                
                // Rapidly change dice value during animation for visual effect
                // Use non-uniform distribution for more natural randomness
                if timeElapsed < rollDuration * 0.6 {
                    // First phase: Rapid, uniform changes
                    self.diceResult = Int.random(in: 1...6)
                } else if timeElapsed < rollDuration * 0.9 {
                    // Second phase: Start to slow down, favor certain outcomes
                    let possibleValues = [1, 2, 3, 4, 5, 6, Int.random(in: 1...6), Int.random(in: 1...6)]
                    self.diceResult = possibleValues.randomElement() ?? Int.random(in: 1...6)
                }
                
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
                    self.audioManager.playSound(sound: "dice_land")
                    
                    // 3. Final bounce animation sequence
                    // First bounce (larger)
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                        diceScale = 1.08 // Slightly larger than normal
                    }
                    
                    // Second bounce (smaller)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.5)) {
                            diceScale = 1.03
                        }
                        
                        // Final settle
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                diceScale = 1.0
                            }
                            
                            // Reset rolling state to enable button
                            self.isRolling = false
                        }
                    }
                }
            }
        }
    }
}

// Structure to track animation state for smoother transitions
struct DiceAnimationState {
    var shakeDuration: Double = 0.5
    var rollDuration: Double = 2.0
    var landingDuration: Double = 0.3
    var isShaking: Bool = false
    var isLanding: Bool = false
}
