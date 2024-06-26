

// Abstract:
// This Swift app demonstrates the use of Monte Carlo simulation to estimate future stock prices.
// It simulates 30 trading days of Apple stock prices multiple times, using geometric Brownian motion.
// The app calculates and displays the mean estimated price, as well as a range of possible prices.
// It also visualizes the simulated price paths using SwiftUI and Charts.

import SwiftUI
import Charts

// Structure to represent daily stock price
struct StockPrice: Identifiable {
    let id = UUID()
    let day: Int
    let price: Double
}

// Main content view for the app
struct ContentView: View {
    @State private var simulatedPrices: [[StockPrice]] = []
    @State private var meanFinalPrice: Double = 0
    @State private var lowEstimate: Double = 0
    @State private var highEstimate: Double = 0

    // Constants for simulation
    let initialPrice: Double = 150.0  // Starting price for AAPL
    let numDays: Int = 30             // Number of trading days to simulate
    let numSimulations: Int = 1000    // Number of simulation runs
    let annualVolatility: Double = 0.3  // Annual volatility (30%)
    let annualDrift: Double = 0.05    // Annual drift (5% expected return)

    var body: some View {
        VStack {
            Text("Apple Stock Price Monte Carlo Simulation")
                .font(.headline)
            
            // Display simulation results
            Text("Mean Estimated Price: $\(meanFinalPrice, specifier: "%.2f")")
            Text("95% Confidence Interval:")
            Text("$\(lowEstimate, specifier: "%.2f") - $\(highEstimate, specifier: "%.2f")")

            // Chart to visualize simulated price paths
            Chart {
                ForEach(simulatedPrices.prefix(100), id: \.self) { series in
                    LineMark(
                        x: .value("Day", series.map { $0.day }),
                        y: .value("Price", series.map { $0.price })
                    )
                    .foregroundStyle(.blue.opacity(0.1))
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

    // Function to run the Monte Carlo simulation
    func runSimulation() {
        var allFinalPrices: [Double] = []
        simulatedPrices = []

        // Calculate daily drift and volatility
        let dailyDrift = annualDrift / 252  // Assuming 252 trading days in a year
        let dailyVolatility = annualVolatility / sqrt(252)

        // Run multiple simulations
        for _ in 0..<numSimulations {
            var prices: [StockPrice] = [StockPrice(day: 0, price: initialPrice)]
            var currentPrice = initialPrice

            // Simulate price movement for each day
            for day in 1...numDays {
                let randomFactor = Double.random(in: -3...3)  // Represents random market factors
                let dailyReturn = exp(dailyDrift + dailyVolatility * randomFactor)
                currentPrice *= dailyReturn
                prices.append(StockPrice(day: day, price: currentPrice))
            }

            simulatedPrices.append(prices)
            allFinalPrices.append(currentPrice)
        }

        // Calculate statistics from the simulations
        meanFinalPrice = allFinalPrices.reduce(0, +) / Double(numSimulations)
        allFinalPrices.sort()
        lowEstimate = allFinalPrices[Int(Double(numSimulations) * 0.025)]
        highEstimate = allFinalPrices[Int(Double(numSimulations) * 0.975)]
    }
}
