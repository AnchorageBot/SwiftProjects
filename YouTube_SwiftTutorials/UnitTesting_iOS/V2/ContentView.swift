//
// BasicMath
// ContentView.swift
//
// Created on 9/15/24
// Updated on 9/15/24
// Swift Version 5.0+
//
// ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:

This file defines the main user interface for the BasicMath application (Version 2).

It allows the user to enter two integers and performs basic arithmetic operations
(addition, subtraction, multiplication, division) on them. The results are displayed
along with classifications of the numbers (odd, even, prime).

Key components:
- User input for two integers
- Display of arithmetic operation results
- Number classification (odd, even, prime)
- List of saved number pairs with their properties
*/

import SwiftUI
import SwiftData

/// Checks if a number is odd
/// - Parameter number: The number to check
/// - Returns: True if the number is odd, false otherwise
func isOdd(_ number: Int) -> Bool {
    return number % 2 != 0
}

/// Checks if a number is even
/// - Parameter number: The number to check
/// - Returns: True if the number is even, false otherwise
func isEven(_ number: Int) -> Bool {
    return number % 2 == 0
}

/// Checks if a number is prime
/// - Parameter number: The number to check
/// - Returns: True if the number is prime, false otherwise
func isPrime(_ number: Int) -> Bool {
    guard number > 1 else { return false }
    for i in 2..<Int(Double(number).squareRoot()) + 1 {
        if number % i == 0 {
            return false
        }
    }
    return true
}

/// The main view of the BasicMath app
struct ContentView: View {
    
    // Access the SwiftData model context
    @Environment(\.modelContext) var context
    
    // State variables to hold the input numbers
    @State private var number1 = ""
    @State private var number2 = ""
    
    // State variables to hold the results
    @State private var sum = 0
    @State private var difference = 0
    @State private var product = 0
    @State private var quotient = 0.0
    
    // Query to fetch all NumberListItems
    @Query var items: [NumberListItem]
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Enter first number", text: $number1)
                        .keyboardType(.numberPad)
                    TextField("Enter second number", text: $number2)
                        .keyboardType(.numberPad)
                    Button("Calculate") {
                        calculateResults()
                    }
                }
                
                Section(header: Text("Results")) {
                    Text("Sum: \(sum)")
                    Text("Difference: \(difference)")
                    Text("Product: \(product)")
                    Text("Quotient: \(String(format: "%.2f", quotient))")
                }
                
                Section(header: Text("Number Properties")) {
                    if let num1 = Int(number1) {
                        Text("Number 1 is: \(classifyNumber(num1))")
                    }
                    if let num2 = Int(number2) {
                        Text("Number 2 is: \(classifyNumber(num2))")
                    }
                }
                
                Section(header: Text("Saved Number Pairs")) {
                    List {
                        ForEach(items) { item in
                            Text(item.title)
                        }
                        .onDelete { indexSet in
                            // Delete selected items
                            for index in indexSet {
                                context.delete(items[index])
                            }
                        }
                    }
                    .overlay {
                        if items.isEmpty {
                            Text("No saved number pairs")
                        }
                    }
                }
            }
            .navigationTitle("BasicMath V2")
        }
    }
    
    // MARK: - Helper Functions
    
    /// Calculates the results of arithmetic operations and saves the number pair
    private func calculateResults() {
        guard let num1 = Int(number1), let num2 = Int(number2) else {
            return
        }
        
        sum = num1 + num2
        difference = num1 - num2
        product = num1 * num2
        quotient = num2 != 0 ? Double(num1) / Double(num2) : 0
        
        // Save the number pair
        let newItem = NumberListItem(title: "\(num1) and \(num2)", subtitle: "Sum: \(sum)", date: Date())
        context.insert(newItem)
    }
    
    /// Classifies a number as odd, even, and/or prime
    /// - Parameter number: The number to classify
    /// - Returns: A string describing the number's properties
    private func classifyNumber(_ number: Int) -> String {
        var properties: [String] = []
        if isOdd(number) { properties.append("odd") }
        if isEven(number) { properties.append("even") }
        if isPrime(number) { properties.append("prime") }
        return properties.joined(separator: ", ")
    }
}

#Preview {
    ContentView()
}
