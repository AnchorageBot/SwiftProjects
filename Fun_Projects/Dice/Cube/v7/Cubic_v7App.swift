//
// Cubic_v7
// Cubic_v7App.swift
//
// Created on 5/4/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI
import AVFoundation

// The main app entry point marked with @main attribute
@main
struct Cubic_v7App: App {
    // Create a shared audio player manager that can be accessed by all views
    @StateObject private var audioManager = AudioManager()
    
    // The body property defines the app structure
    var body: some Scene {
        // WindowGroup is a container for our app's UI
        WindowGroup {
            // Set ContentView as the root view and inject the audio manager
            ContentView()
                .environmentObject(audioManager)
                .preferredColorScheme(.dark) // Force dark mode for better visual appearance
        }
    }
}

// AudioManager class to handle sound effects throughout the app
class AudioManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    // Play a sound effect with a given name
    func playSound(sound: String, type: String = "wav") {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
                // Fallback to system sound if custom sound isn't available
                AudioServicesPlaySystemSound(1104) // Standard system sound as fallback
            }
        } else {
            print("Sound file not found")
            // Fallback to system sound if custom sound isn't available
            AudioServicesPlaySystemSound(1104) // Standard system sound as fallback
        }
    }
}
