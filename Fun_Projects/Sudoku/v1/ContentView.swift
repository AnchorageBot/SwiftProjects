//
// SudokuApp_V1
// ContentView.swift
//
// Created on 4/10/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// **MARK: - Main Content View**
struct ContentView: View {
    @State private var isGameStarted = false
    @State private var selectedDifficulty: SudokuGame.Difficulty = .medium
    
    var body: some View {
        NavigationView {
            if isGameStarted {
                SudokuGameView()
                    .navigationBarTitle("SudokuApp V1", displayMode: .inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            isGameStarted = false
                        }) {
                            Text("Main Menu")
                        }
                    )
            } else {
                // **MARK: - Welcome Screen**
                VStack(spacing: 30) {
                    Text("SudokuApp V1")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Image(systemName: "square.grid.3x3.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .foregroundColor(.blue)
                    
                    // **MARK: - Difficulty Selection**
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Select Difficulty:")
                            .font(.headline)
                        
                        Picker("Difficulty", selection: $selectedDifficulty) {
                            Text("Easy").tag(SudokuGame.Difficulty.easy)
                            Text("Medium").tag(SudokuGame.Difficulty.medium)
                            Text("Hard").tag(SudokuGame.Difficulty.hard)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        isGameStarted = true
                    }) {
                        Text("Start Game")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    // **MARK: - Additional Options**
                    VStack(spacing: 15) {
                        Button(action: {
                            // Open instructions or help screen
                            // This would typically navigate to another view
                        }) {
                            Text("How to Play")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        
                        Button(action: {
                            // Open settings screen
                            // This would typically navigate to another view
                        }) {
                            Text("Settings")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Spacer()
                    
                    Text("© 2025 ATS Project")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
    }
}

// **MARK: - Preview Provider**
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
