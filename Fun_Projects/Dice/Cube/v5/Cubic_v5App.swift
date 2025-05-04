//
// Cubic_v5
// Cubic_v5App.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI
import AVFoundation

// The main app entry point marked with @main attribute
@main
struct Cubic_v5App: App {
    // Create a shared audio player manager that can be accessed by all views
    @StateObject private var audioManager = AudioManager()
    
    // The body property defines the app structure
    var body: some Scene {
        // WindowGroup is a container for our app's UI
        WindowGroup {
            // Set ContentView as the root view and inject the audio manager
            ContentView()
                .environmentObject(audioManager)
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
            }
        } else {
            print("Sound file not found")
        }
    }
}
