//
// SudokuApp_V1
// SudokuApp_V1App.swift
//
// Created on 4/10/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

//SudokuApp.swift - The main app entry point
//Models/SudokuGame.swift - The game model with logic for puzzle generation
//Views/SudokuCellView.swift - The view for individual Sudoku cells
//Views/SudokuGridView.swift - The view for the entire 9x9 grid
//Views/NumberPadView.swift - The number pad for user input
//Views/SudokuGameView.swift - The main game view that combines all components

import SwiftUI

// MARK: - App Entry Point

// Uses SudokuGameView() as the entry point
//@main
//struct SudokuApp_V1: App {
//    var body: some Scene {
//        WindowGroup {
//            SudokuGameView()
//        }
//    }
//}


// Uses ContentView() as the entry point
@main
struct SudokuApp_V1: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
