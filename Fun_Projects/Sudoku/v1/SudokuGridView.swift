//
// SudokuApp_V1
// SudokuGridView.swift
//
// Created on 4/12/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// MARK: - View
struct SudokuGridView: View {
    @Binding var game: SudokuGame
    @State private var selectedCell: (row: Int, col: Int)? = nil
    @State private var showingNumberPad = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<9) { row in
                HStack(spacing: 0) {
                    ForEach(0..<9) { col in
                        SudokuCellView(
                            value: game.value(at: row, col),
                            row: row,
                            col: col,
                            isEditable: game.isEditable(at: row, col),
                            onCellTap: { r, c in
                                if game.isEditable(at: r, c) {
                                    selectedCell = (r, c)
                                    showingNumberPad = true
                                }
                            }
                        )
                        .background(
                            selectedCell?.row == row && selectedCell?.col == col ?
                                Color.yellow.opacity(0.3) : Color.clear
                        )
                        .overlay(
                            // Add thicker borders for 3x3 boxes
                            GeometryReader { geometry in
                                ZStack {
                                    if col % 3 == 2 && col < 8 {
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(width: 2)
                                            .position(x: geometry.size.width, y: geometry.size.height / 2)
                                    }
                                    if row % 3 == 2 && row < 8 {
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(height: 2)
                                            .position(x: geometry.size.width / 2, y: geometry.size.height)
                                    }
                                }
                            }
                        )
                    }
                }
            }
        }
        .border(Color.black, width: 2)
        .padding()
        .overlay(
            VStack {
                if showingNumberPad, let cell = selectedCell {
                    NumberPadView { number in
                        if let number = number {
                            game.updateCell(at: cell.row, col: cell.col, with: number)
                        } else {
                            // Clear the cell
                            game.updateCell(at: cell.row, col: cell.col, with: 0)
                        }
                        showingNumberPad = false
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .transition(.scale)
                }
            }
            .animation(.spring(), value: showingNumberPad)
            .padding()
            , alignment: .bottom
        )
    }
}


