//
// SudokuApp_V1
// NumberPadView.swift
//
// Created on 4/12/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// MARK: - View
struct NumberPadView: View {
    let onNumberSelected: (Int?) -> Void
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1...3, id: \.self) { number in
                    numberButton(number)
                }
            }
            HStack {
                ForEach(4...6, id: \.self) { number in
                    numberButton(number)
                }
            }
            HStack {
                ForEach(7...9, id: \.self) { number in
                    numberButton(number)
                }
            }
            HStack {
                Button(action: {
                    onNumberSelected(nil)
                }) {
                    Text("Clear")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    onNumberSelected(0) // 0 means cancel without changing
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
    
    private func numberButton(_ number: Int) -> some View {
        Button(action: {
            onNumberSelected(number)
        }) {
            Text("\(number)")
                .font(.title)
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(25)
        }
    }
}

