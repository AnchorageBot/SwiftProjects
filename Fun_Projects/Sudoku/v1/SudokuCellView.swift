//
// SudokuApp_V1
// Views/SudokuCellView.swift
//
// Created on 4/10/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

struct SudokuCellView: View {
    let value: Int
    let row: Int
    let col: Int
    let isEditable: Bool
    let onCellTap: (Int, Int) -> Void
    
    var body: some View {
        Button(action: {
            onCellTap(row, col)
        }) {
            Text(value == 0 ? "" : "\(value)")
                .font(.system(size: 20, weight: .bold))
                .frame(width: 35, height: 35)
                .foregroundColor(isEditable ? .blue : .black)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .border(Color.gray, width: 0.5)
                )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEditable)
    }
}
