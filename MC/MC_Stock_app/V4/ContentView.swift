//
//  ContentView.swift
//  MonteCarloStock
//
//  Created by ATS and Claude on 6/25/24
//  Made with Xcode 15.4
//

// Abstract:
// This Swift app demonstrates the use of Monte Carlo simulation to estimate future stock prices.
// It allows users to configure parameters such as initial price, number of days, volatility, and drift.
// The app simulates stock prices using geometric Brownian motion, calculates statistics,
// and visualizes the simulated price paths using SwiftUI and Charts.

import SwiftUI
import Charts

// Define a struct to represent a single stock price data point
struct StockPrice: Identifiable, Hashable {
    let id = UUID()
    let day: Int
    let price: Double
    
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
        ScrollView {
            VStack(spacing: 20) {
                Text("Apple Stock Price Monte Carlo Simulation")
                    .font(.headline)
                
                // User input section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Initial Price: $")
                        TextField("", value: $initialPrice, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Number of Days:")
                        TextField("", value: $numDays, format: .number)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Annual Volatility:")
                        TextField("", value: $annualVolatility, format: .percent)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Annual Drift:")
                        TextField("", value: $annualDrift, format: .percent)
                            .keyboardType(.decimalPad)
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Simulation results
                VStack {
                    Text("Mean Estimated Price: $\(meanFinalPrice, specifier: "%.2f")")
                    Text("95% Confidence Interval:")
                    Text("$\(lowEstimate, specifier: "%.2f") - $\(highEstimate, specifier: "%.2f")")
                }
                
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
                
                // Button to trigger a new simulation
                Button("Run Simulation") {
                    runSimulation()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
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
