//
// Cubic_v8
// AudioManager.swift // <-- New File
//
// Created on 5/12/25
// Swift Version 6.0 (or latest applicable)
//
// ATS Project
// Assisted by Anthropic's AI Claude & Google's AI Gemini
//

import Foundation
import AVFoundation   // Needed for AVAudioPlayer
import AudioToolbox // Needed for AudioServicesPlaySystemSound
import Combine       // Needed for ObservableObject

// AudioManager class to handle sound effects throughout the app
// Make sure it's ObservableObject to work with @StateObject/@EnvironmentObject
class AudioManager: ObservableObject {
    // Dictionary to hold preloaded audio players
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    // System Sound ID for fallback
    private let fallbackSoundID: SystemSoundID = 1104 // Standard system sound (tock)

    init() {
        // Preload common sounds when the manager is initialized
        preloadSounds()
    }

    // Preload sounds to avoid delay on first playback
    private func preloadSounds() {
        let soundsToLoad = ["dice_roll", "dice_land"]
        for soundName in soundsToLoad {
            guard let path = Bundle.main.path(forResource: soundName, ofType: "wav") else {
                print("Warning: Sound file '\(soundName).wav' not found.")
                continue
            }
            let url = URL(fileURLWithPath: path)
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                // Prepare the player but don't play it yet.
                // Preparing reduces latency when play() is called.
                player.prepareToPlay()
                audioPlayers[soundName] = player
                print("Successfully preloaded sound: \(soundName)")
            } catch {
                print("Error preloading sound '\(soundName)': \(error.localizedDescription)")
            }
        }
    }

    // Play a sound effect with a given name (expects preloaded sounds)
    func playSound(sound: String) {
        // Check if the player for this sound exists and is preloaded
        if let player = audioPlayers[sound] {
            // Optional: Stop the player if it's already playing, to restart the sound
             if player.isPlaying {
                 player.stop()
                 player.currentTime = 0 // Rewind to the beginning
                 player.prepareToPlay() // Re-prepare quickly if needed
             }
            player.play()
        } else {
            // If the sound wasn't preloaded or failed to load, play fallback
            print("Sound '\(sound)' not preloaded or failed. Playing fallback system sound.")
            AudioServicesPlaySystemSound(fallbackSoundID)
        }
    }
}
