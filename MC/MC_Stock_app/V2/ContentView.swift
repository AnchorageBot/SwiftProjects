//
//  ContentView.swift
//  MonteCarloStock
//
//  Created by ATS and Claude on 6/25/24
//  Made with Xcode 15.4
//

// Abstract:
// This Swift app demonstrates the use of Monte Carlo simulation to estimate future stock prices.
// It simulates 30 trading days of Apple stock prices multiple times, using geometric Brownian motion.
// The app calculates and displays the mean estimated price, as well as a range of possible prices.
// It also visualizes the simulated price paths using SwiftUI and Charts.

import SwiftUI
import Charts

// Make StockPrice conform to Hashable
struct StockPrice: Identifiable, Hashable {
    let id = UUID()
    let day: Int
    let price: Double
    
    // Implement hash(into:) method
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ContentView: View {
    @State private var simulatedPrices: [[StockPrice]] = []
    @State private var meanFinalPrice: Double = 0
    @State private var lowEstimate: Double = 0
    @State private var highEstimate: Double = 0

    let initialPrice: Double = 150.0
    let numDays: Int = 30
    let numSimulations: Int = 1000
    let annualVolatility: Double = 0.3
    let annualDrift: Double = 0.05

    var body: some View {
        VStack {
            Text("Apple Stock Price Monte Carlo Simulation")
                .font(.headline)
            
            Text("Mean Estimated Price: $\(meanFinalPrice, specifier: "%.2f")")
            Text("95% Confidence Interval:")
            Text("$\(lowEstimate, specifier: "%.2f") - $\(highEstimate, specifier: "%.2f")")

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

            Button("Run Simulation") {
                runSimulation()
            }
        }
        .padding()
    }
    
    func runSimulation() {
        var allFinalPrices: [Double] = []
        simulatedPrices = []

        let dailyDrift = annualDrift / 252
        let dailyVolatility = annualVolatility / sqrt(252)

        for _ in 0..<numSimulations {
            var prices: [StockPrice] = [StockPrice(day: 0, price: initialPrice)]
            var currentPrice = initialPrice

            for day in 1...numDays {
                let randomFactor = Double.random(in: -3...3)
                let dailyReturn = exp(dailyDrift + dailyVolatility * randomFactor)
                currentPrice *= dailyReturn
                prices.append(StockPrice(day: day, price: currentPrice))
            }

            simulatedPrices.append(prices)
            allFinalPrices.append(currentPrice)
        }

        meanFinalPrice = allFinalPrices.reduce(0, +) / Double(numSimulations)
        allFinalPrices.sort()
        lowEstimate = allFinalPrices[Int(Double(numSimulations) * 0.025)]
        highEstimate = allFinalPrices[Int(Double(numSimulations) * 0.975)]
    }
}
