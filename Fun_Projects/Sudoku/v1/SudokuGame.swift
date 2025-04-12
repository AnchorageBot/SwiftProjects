//
// SudokuApp_V1
// SudokuGame.swift
//
// Created on 4/12/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude

import SwiftUI

// MARK: - Model
struct SudokuGame {
    // 9x9 grid represented as a 2D array
    private var solution: [[Int]]
    private var puzzle: [[Int]]
    
    // Tracks user's current state of the board
    private var userBoard: [[Int]]
    
    // Difficulty level determines how many cells to reveal
    enum Difficulty {
        case easy
        case medium
        case hard
        
        var cellsToReveal: Int {
            switch self {
            case .easy: return 40  // More cells revealed = easier
            case .medium: return 30
            case .hard: return 24
            }
        }
    }
    
    // Initialize with a new random puzzle
    init(difficulty: Difficulty = .medium) {
        // Start with empty grids
        solution = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        puzzle = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        
        // Generate a solved grid
        generateSolution()
        
        // Create the puzzle by removing numbers from solution
        createPuzzle(difficulty: difficulty)
        
        // Initialize the user board with the puzzle
        userBoard = puzzle
    }
        
    
    // Returns the value at a specific position
    func value(at row: Int, col: Int) -> Int {
        return userBoard[row][col]
    }
    
    // Returns whether a cell is editable (was empty in the original puzzle)
    func isEditable(at row: Int, col: Int) -> Bool {
        return puzzle[row][col] == 0
    }
    
    // Updates a cell with user input
    mutating func updateCell(at row: Int, col: Int, with value: Int) {
        // Only allow updates to cells that were empty in the original puzzle
        if isEditable(at: row, col) {
            userBoard[row][col] = value
        }
    }
    
    // Check if the current user board is valid and complete
    func isComplete() -> Bool {
        // Check if every cell is filled
        for row in 0..<9 {
            for col in 0..<9 {
                if userBoard[row][col] == 0 {
                    return false
                }
            }
        }
        
        // Check if every row, column, and box is valid
        return isValid()
    }
    
    // Verify that the current board follows Sudoku rules
    func isValid() -> Bool {
        // Check rows
        for row in 0..<9 {
            var seen = Set<Int>()
            for col in 0..<9 {
                let value = userBoard[row][col]
                if value != 0 {
                    if seen.contains(value) {
                        return false
                    }
                    seen.insert(value)
                }
            }
        }
        
        // Check columns
        for col in 0..<9 {
            var seen = Set<Int>()
            for row in 0..<9 {
                let value = userBoard[row][col]
                if value != 0 {
                    if seen.contains(value) {
                        return false
                    }
                    seen.insert(value)
                }
            }
        }
        
        // Check 3x3 boxes
        for boxRow in 0..<3 {
            for boxCol in 0..<3 {
                var seen = Set<Int>()
                for row in 0..<3 {
                    for col in 0..<3 {
                        let value = userBoard[boxRow * 3 + row][boxCol * 3 + col]
                        if value != 0 {
                            if seen.contains(value) {
                                return false
                            }
                            seen.insert(value)
                        }
                    }
                }
            }
        }
        
        return true
    }
    
    // Reset the user board to the original puzzle
    mutating func resetPuzzle() {
        userBoard = puzzle
    }
    
    // Generate a new puzzle with the same difficulty
    mutating func newGame(difficulty: Difficulty = .medium) {
        // Clear the grid
        solution = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        
        // Generate a new solution
        generateSolution()
        
        // Create a new puzzle
        createPuzzle(difficulty: difficulty)
        
        // Reset the user board
        userBoard = puzzle
    }
    
