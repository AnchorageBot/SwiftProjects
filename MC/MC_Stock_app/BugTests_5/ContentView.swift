//
//  ContentView.swift
//  MonteCarloStock
//
//  Created by ATS and Claude and updated on 6/29/24
//  Made with Xcode 15.4
//

// Abstract:
// This Swift file defines the main view for the Monte Carlo Stock Price Simulator app.
// It includes user input fields, simulation controls, result display, and a chart visualization.
// The view is designed with accessibility in mind, particularly for VoiceOver users.

import SwiftUI
import Charts

// Define a struct to represent a single stock price data point
struct StockPrice: Identifiable, Hashable {
    let id = UUID()  // Unique identifier for each price point
    let day: Int     // The day of the simulation (0-30)
    let price: Double  // The simulated stock price for this day
    
    // Implement hash method for Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ContentView: View {
    // State variables for user inputs
    @State private var initialPrice: Double = 150.0
    @State private var numDays: Int = 30
    @State private var annualVolatility: Double = 0.3
    @State private var annualDrift: Double = 0.05
    
    // State variables for simulation results
    @State private var simulatedPrices: [[StockPrice]] = []
    @State private var meanFinalPrice: Double = 0
    @State private var lowEstimate: Double = 0
    @State private var highEstimate: Double = 0
    
    // Constant for number of simulations
    let numSimulations: Int = 1000
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // User input section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Initial Price: $")
                            TextField("", value: $initialPrice, format: .number)
                                .keyboardType(.decimalPad)
                                .accessibilityLabel("Initial stock price")
                        }
                        HStack {
                            Text("Number of Days:")
                            TextField("", value: $numDays, format: .number)
                                .keyboardType(.numberPad)
                                .accessibilityLabel("Number of simulation days")
                        }
                        HStack {
                            Text("Annual Volatility:")
                            TextField("", value: $annualVolatility, format: .percent)
                                .keyboardType(.decimalPad)
                                .accessibilityLabel("Annual stock price volatility")
                        }
                        HStack {
                            Text("Annual Drift:")
                            TextField("", value: $annualDrift, format: .percent)
                                .keyboardType(.decimalPad)
                                .accessibilityLabel("Annual stock price drift")
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    // Buttons section
                    HStack {
                        // Button to trigger a new simulation
                        Button("Run Simulation") {
                            runSimulation()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .accessibilityHint("Starts the stock price simulation with current parameters")
                        
                        // Navigation link to the Glossary view
                        NavigationLink(destination: GlossaryView()) {
                            Text("Glossary")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .accessibilityHint("Opens a glossary of financial terms")
                    }
                    
                    // Simulation results
                    VStack {
                        Text("Mean Estimated Price: $\(meanFinalPrice, specifier: "%.2f")")
                            .accessibilityLabel("Mean estimated final stock price: $\(meanFinalPrice, specifier: "%.2f")")
                        Text("95% Confidence Interval:")
                            .accessibilityLabel("95% confidence interval for final stock price")
                        Text("$\(lowEstimate, specifier: "%.2f") - $\(highEstimate, specifier: "%.2f")")
                            .accessibilityLabel("From $\(lowEstimate, specifier: "%.2f") to $\(highEstimate, specifier: "%.2f")")
                    }
                    .padding()
                    
                    // Chart to visualize simulation results
                    Chart {
                        ForEach(simulatedPrices.prefix(100), id: \.self) { series in
                            ForEach(series) { price in
                                LineMark(
                                    x: .value("Day", price.day),
                                    y: .value("Price", price.price)
                                )
                            }
                            .foregroundStyle(.blue.opacity(0.1))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                    }
                    .frame(height: 300)
                    .padding()
                    .accessibilityLabel("Chart showing 100 simulated stock price paths")
                    .accessibilityHint("Each line represents a possible stock price path over the simulation period")
                }
            }
            .navigationTitle("Stock Price Simulator")
        }
    }
    
    // Function to perform the Monte Carlo simulation
    func runSimulation() {
        var allFinalPrices: [Double] = []
        simulatedPrices = []
        
        // Calculate daily drift and volatility from annual values
        let dailyDrift = annualDrift / 252  // Assuming 252 trading days per year
        let dailyVolatility = annualVolatility / sqrt(252)
        
        // Run multiple simulations
        for _ in 0..<numSimulations {
            var prices: [StockPrice] = [StockPrice(day: 0, price: initialPrice)]
            var currentPrice = initialPrice
            
            // Simulate price changes for each day
            for day in 1...numDays {
                let randomFactor = Double.random(in: -3...3)  // Random market factor
                let dailyReturn = exp(dailyDrift + dailyVolatility * randomFactor)
                currentPrice *= dailyReturn
                prices.append(StockPrice(day: day, price: currentPrice))
            }
            
            simulatedPrices.append(prices)
            allFinalPrices.append(currentPrice)
        }
        
        // Calculate summary statistics
        meanFinalPrice = allFinalPrices.reduce(0, +) / Double(numSimulations)
        allFinalPrices.sort()
        lowEstimate = allFinalPrices[Int(Double(numSimulations) * 0.025)]  // 2.5th percentile
        highEstimate = allFinalPrices[Int(Double(numSimulations) * 0.975)]  // 97.5th percentile
    }
}

// Preview provider for SwiftUI canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
