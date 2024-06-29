Made with [Anthropic's AI Claude](https://claude.ai/login)

- - - -

_Note: This app is for educational purposes only and should not be used for actual financial decision-making._

- - - -

# Monte Carlo Stock Price Simulator

## Overview

This Swift app demonstrates the use of Monte Carlo simulation to estimate future stock prices. Built with SwiftUI and Charts, it provides an interactive interface for users to explore potential stock price outcomes based on various parameters.

## Features

- Simulates stock prices using geometric Brownian motion
- Configurable parameters: initial price, number of days, volatility, and drift
- Runs 1000 simulations for each set of parameters
- Displays mean estimated price and 95% confidence interval
- Visualizes 100 simulated price paths using SwiftUI Charts
- Includes a glossary of key financial terms

## Requirements

- Xcode 15.4 or later
- iOS 16.0 or later
- Swift 5.0 or later

## Installation

1. Clone this repository or download the source code.
2. Open the project in Xcode.
3. Ensure the Charts framework is added to your project:
   - Select your project in the Project Navigator
   - Choose your target under the "TARGETS" section
   - Go to the "General" tab
   - Scroll to "Frameworks, Libraries, and Embedded Content"
   - If Charts is not listed, click the "+" button and add it

## Usage

1. Launch the app on an iOS simulator or device.
2. Adjust the simulation parameters:
   - Initial Price: Starting stock price
   - Number of Days: Simulation duration (1-30 days)
   - Annual Volatility: Stock price variability (as a percentage)
   - Annual Drift: Expected annual return (as a percentage)
3. Tap "Run Simulation" to generate new results.
4. View the mean estimated price and confidence interval.
5. Explore the chart showing 100 simulated price paths.
6. Access the Glossary for definitions of key terms.

## Code Structure

- `ContentView.swift`: Main view containing user inputs, simulation logic, and results display
- `GlossaryView.swift`: View presenting definitions of key financial terms
- `MonteCarloStockApp.swift`: Main app file defining the app structure

## License

This project is open source and available under the [MIT License](LICENSE).

---

_Note: This app is for educational purposes only and should not be used for actual financial decision-making._
