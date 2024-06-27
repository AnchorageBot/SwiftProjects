// Abstract:
// This Swift app demonstrates the use of Monte Carlo simulation to estimate future stock prices.
// It simulates 30 trading days of Apple stock prices multiple times, using geometric Brownian motion.
// The app calculates and displays the mean estimated price, as well as a range of possible prices.
// It also visualizes the simulated price paths using SwiftUI and Charts.

//  ContentView.swift
//  MonteCarloStock
//
//  Created by ATS and Claude on 6/25/24
//  Made with Xcode 15.4

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
    // State variables to hold simulation results
    @State private var simulatedPrices: [[StockPrice]] = []
    @State private var meanFinalPrice: Double = 0
    @State private var lowEstimate: Double = 0
    @State private var highEstimate: Double = 0

    // Constants for simulation parameters
    let initialPrice: Double = 150.0     // Starting stock price
    let numDays: Int = 30                // Number of days to simulate
    let numSimulations: Int = 1000       // Number of simulation runs
    let annualVolatility: Double = 0.3   // Annual price volatility (30%)
    let annualDrift: Double = 0.05       // Annual expected return (5%)

    var body: some View {
        VStack {
            // Title of the app
            Text("Apple Stock Price Monte Carlo Simulation")
                .font(.headline)
            
            // Display simulation results
            Text("Mean Estimated Price: $\(meanFinalPrice, specifier: "%.2f")")
            Text("95% Confidence Interval:")
            Text("$\(lowEstimate, specifier: "%.2f") - $\(highEstimate, specifier: "%.2f")")

            // Chart to visualize simulation results
            Chart {
                // Display up to 100 simulated price paths
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
        }
        .padding()
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
