//
// SudokuApp_V1
// SudokuGameView.swift
//
// Created on 4/12/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// MARK: - View
struct SudokuGameView: View {
    @State private var game = SudokuGame()
    @State private var difficulty: SudokuGame.Difficulty = .medium
    @State private var showingWinMessage = false
    
    var body: some View {
        VStack {
            Text("Sudoku")
                .font(.largeTitle)
                .padding()
            
            SudokuGridView(game: $game)
            
            HStack {
                Button("New Game") {
                    game.newGame(difficulty: difficulty)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Reset") {
                    game.resetPuzzle()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Check") {
                    if game.isComplete() {
                        showingWinMessage = true
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            Picker("Difficulty", selection: $difficulty) {
                Text("Easy").tag(SudokuGame.Difficulty.easy)
                Text("Medium").tag(SudokuGame.Difficulty.medium)
                Text("Hard").tag(SudokuGame.Difficulty.hard)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: difficulty) { _ in
                game.newGame(difficulty: difficulty)
            }
        }
        .alert("Congratulations!", isPresented: $showingWinMessage) {
            Button("New Game") {
                game.newGame(difficulty: difficulty)
            }
            Button("OK") {}
        } message: {
            Text("You've successfully completed the puzzle!")
        }
    }
}


