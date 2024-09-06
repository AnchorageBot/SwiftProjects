//
// TipCalculator
// ContentView.swift
//
// Created on 9/5/24
// Swift Version 5.0
//
// ATS Project
//

import SwiftUI

/*
Abstract:
This file contains the ContentView struct for a tip calculator app.
It provides a user interface for entering a bill amount, selecting a tip percentage,
and displaying the calculated tip and total amount.

The view includes:
- Text input for the bill amount
- A slider for selecting the tip percentage
- Displays for the calculated tip amount and total bill
*/

struct ContentView: View {
    // MARK: - Properties
    
    // State variables to store user input and calculated values
    @State private var enteredAmount: String = ""
    @State private var tipAmount: Double = 0
    @State private var totalAmount: Double = 0
    @State private var tipSlider: Double = 15 // Default tip percentage
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 40) {
            VStack {
                // Text label for bill amount input
                Text("Enter Bill Amount")
                    .foregroundColor(.secondary)
                
                // Text field for entering the bill amount
                TextField("0.00", text: $enteredAmount)
                    .font(.system(size: 70, weight: .semibold, design: .rounded))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
            }
            
            // Text display for the current tip percentage
            Text("Tip: \(tipSlider, specifier: "%.0f")%")
            
            // Slider for adjusting the tip percentage
            Slider(value: $tipSlider, in: 0...100, step: 1)
                .onChange(of: tipSlider) { _ in
                    updateCalculations()
                }
            
            VStack {
                // Display for the calculated tip amount
                Text(tipAmount, format: .currency(code: "USD"))
                    .font(.title.bold())
                
                Text("Tip")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(.top, 20)
            
            VStack {
                // Display for the total amount (bill + tip)
                Text(totalAmount, format: .currency(code: "USD"))
                    .font(.title.bold())
                
                Text("Total")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
        .padding(30)
    }
    
    // MARK: - Helper Methods
    
    // Method to update calculations when input changes
    private func updateCalculations() {
        guard let amount = Double(enteredAmount) else {
            print("Invalid Entry")
            return
        }
        
        guard let tip = Calculation().calculateTip(of: amount, with: tipSlider) else {
            print("Bill amount or tip cannot be negative")
            return
        }
        
        tipAmount = tip
        totalAmount = amount + tipAmount
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Calculation Struct

struct Calculation {
    func calculateTip(of enteredAmount: Double, with tip: Double) -> Double? {
        guard enteredAmount >= 0 && tip >= 0 else { return nil }
        let tipPercentage = tip / 100
        return enteredAmount * tipPercentage
    }
}
