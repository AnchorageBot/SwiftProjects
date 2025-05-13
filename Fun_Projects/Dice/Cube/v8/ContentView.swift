//
// Cubic_v8
// ContentView.swift
//
// Created on 5/4/25 (as per original)
// Refactored to v8 on 5/12/25
// Swift Version 6.0 (or latest applicable)
//
// ATS Project
// Assisted by Anthropic's AI Claude & Google's AI Gemini
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

    // Dice appearance settings - using a richer red color
    let diceColor = Color(red: 0.85, green: 0.1, blue: 0.1) // Standard Color init

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
            // Using standard Color initializers
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.25, green: 0.25, blue: 0.35), // Dark grayish blue
                    Color(red: 0.12, green: 0.12, blue: 0.18)  // Darker blue/purple
                ]),
                center: .center,
                startRadius: 1,
                endRadius: 400
            )
            .ignoresSafeArea() // Use ignoresSafeArea() instead of edgesIgnoringSafeArea()

            VStack {
                // Title with improved styling
                Text("Cubic Dice v8") // Updated title
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

                    // Our refined 3D dice implementation
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
                                // Display history in reverse chronological order
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
                                    .accessibilityLabel("Roll number \(rollHistory.count - index): \(rollHistory[index])")
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 65) // Increased height slightly for padding
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
                                                .frame(height: 20) // Height of the highlight area
                                                .offset(y: -13) // Position the highlight near the top
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
                                                .frame(height: 30) // Size of highlight area
                                                .offset(y: -10) // Position highlight near top
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

        // --- Animation Constants ---
        let initialScaleDownDuration = 0.2
        let rotationStiffness = 40.0
        let rotationDamping = 7.0
        let rotationInitialVelocity = 7.0
        let rotationAnimationSpeed = 0.65
        let faceChangeInterval = 0.08 // Time between random face changes
        let totalRollDuration = 2.2   // Total time for the rolling visual effect
        let maxHistoryCount = 10
        let finalBounce1Scale: CGFloat = 1.08
        let finalBounce1Duration = 0.3
        let finalBounce1Damping = 0.4
        let finalBounce2Scale: CGFloat = 1.03
        let finalBounce2Duration = 0.25
        let finalBounce2Damping = 0.5
        let settleDuration = 0.2
        let settleDamping = 0.5
        // --- End Constants ---

        // Set rolling state to true
        isRolling = true

        // Play dice rolling sound
        audioManager.playSound(sound: "dice_roll") // Use updated AudioManager method

        // Trigger haptic feedback
        executeHapticPattern()

        // Generate random rotation end values for realistic tumbling
        let targetX = Double.random(in: 360...720) * (Bool.random() ? 1 : -1)
        let targetY = Double.random(in: 360...720) * (Bool.random() ? 1 : -1)
        let targetZ = Double.random(in: 180...360) * (Bool.random() ? 1 : -1)

        // --- Enhanced Animation Sequence ---

        // 1. Quick scale down to simulate picking up dice
        withAnimation(.easeIn(duration: initialScaleDownDuration)) {
            diceScale = 0.8
        }

        // 2. Main dice rolling animation (starts after initial scale down)
        DispatchQueue.main.asyncAfter(deadline: .now() + initialScaleDownDuration) {
            // Animate the rotation with spring physics
            withAnimation(
                .interpolatingSpring(
                    stiffness: rotationStiffness,
                    damping: rotationDamping,
                    initialVelocity: rotationInitialVelocity
                )
                .speed(rotationAnimationSpeed)
            ) {
                rotationX += targetX
                rotationY += targetY
                rotationZ += targetZ
                diceScale = 1.0 // Return to normal size during rotation
            }

            // Timer to change dice face rapidly during rotation animation
            var timeElapsed = 0.0
            Timer.scheduledTimer(withTimeInterval: faceChangeInterval, repeats: true) { timer in
                timeElapsed += faceChangeInterval

                // Change dice face visually
                if timeElapsed < totalRollDuration * 0.6 { // Faster changes initially
                    self.diceResult = Int.random(in: 1...6)
                } else if timeElapsed < totalRollDuration * 0.9 { // Slower, more varied changes towards end
                    let possibleValues = [1, 2, 3, 4, 5, 6, Int.random(in: 1...6), Int.random(in: 1...6)]
                    self.diceResult = possibleValues.randomElement() ?? Int.random(in: 1...6)
                } // Last 10% allows settling on final result below

                // Check if animation duration is complete
                if timeElapsed >= totalRollDuration {
                    timer.invalidate() // Stop the timer

                    // Set the final random result
                    let finalResult = Int.random(in: 1...6)
                    self.diceResult = finalResult

                    // Add to roll history
                    self.rollHistory.append(finalResult)

                    // Limit history size
                    if self.rollHistory.count > maxHistoryCount {
                        self.rollHistory.removeFirst(self.rollHistory.count - maxHistoryCount)
                    }

                    // Play dice landing sound
                    self.audioManager.playSound(sound: "dice_land") // Use updated AudioManager method

                    // 3. Final bounce animation sequence
                    // First bounce (larger)
                    withAnimation(.spring(response: finalBounce1Duration, dampingFraction: finalBounce1Damping)) {
                        diceScale = finalBounce1Scale
                    }

                    // Second bounce (smaller) - starts after first bounce settles a bit
                    DispatchQueue.main.asyncAfter(deadline: .now() + finalBounce1Duration * 0.7) { // Adjusted timing
                        withAnimation(.spring(response: finalBounce2Duration, dampingFraction: finalBounce2Damping)) {
                            diceScale = finalBounce2Scale
                        }

                        // Final settle - starts after second bounce settles
                        DispatchQueue.main.asyncAfter(deadline: .now() + finalBounce2Duration * 0.7) { // Adjusted timing
                            withAnimation(.spring(response: settleDuration, dampingFraction: settleDamping)) {
                                diceScale = 1.0 // Settle back to normal scale
                            }

                            // Reset rolling state AFTER all animations complete
                            // Allow a tiny bit more time for the settle animation to visually finish
                            DispatchQueue.main.asyncAfter(deadline: .now() + settleDuration) {
                                self.isRolling = false
                            }
                        }
                    }
                }
            }
        }
    }
}

// Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioManager()) // Provide a dummy AudioManager for preview
    }
}
