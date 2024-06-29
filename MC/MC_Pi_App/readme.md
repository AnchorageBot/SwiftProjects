Made with [Anthropic's AI Claude](https://claude.ai/login)

- - - -

# Monte Carlo Pi Estimation

This Swift app demonstrates a Monte Carlo simulation to estimate the value of pi using SwiftUI and Charts.

## Abstract

The Monte Carlo method is a statistical technique that uses random sampling to obtain numerical results. In this app:

- Random points are generated within a 1x1 square.
- The ratio of points falling inside a quarter circle to the total number of points is calculated.
- This ratio approximates pi/4, allowing us to estimate pi.
- The result is visualized using SwiftUI and Charts, showing the estimated value of pi and a scatter plot of the points.

## Features

- Interactive UI to run the simulation
- Real-time visualization of the Monte Carlo process
- Display of the estimated value of pi
- Context view explaining the Monte Carlo method
- Accessibility features for improved usability

## Installation

1. Ensure you have Xcode installed on your Mac. If not, download it from the App Store.
2. Clone this repository or download the source code.

## Running the App

1. Open the project in Xcode.
2. Choose a simulator or connected device as the run target.
3. Click the "Run" button or press Cmd+R to build and run the app.

## Usage

1. Launch the app on your simulator or device.
2. Click the "Run Simulation" button to perform the Monte Carlo estimation of pi.
3. Observe the updated graph showing randomly generated points and the estimated value of pi.
4. Toggle between the simulation view and context view for more information about the method.

## Files

- `MonteCarloPiApp.swift`: Main app file setting up the app structure.
- `ContentView.swift`: Primary view containing the simulation UI and logic.
- `ContextView.swift`: View providing additional information about the Monte Carlo method.

## Requirements

- iOS 15.0+
- Xcode 15.4+
- Swift 5.5+

## Made with

[Anthropic's AI Claude](https://claude.ai/login)

## License

MiT

