# BayesCalculator

## 5th Draft File Structure

```
BayesCalculator/
├── App/
│   └── BayesCalculatorApp.swift
├── Models/
│   ├── RoomData.swift
│   └── CalculationResults.swift
├── ViewModels/
│   └── ProbabilityCalculator.swift
├── Views/
│   ├── ContentView.swift
│   ├── BayesianExplanationView.swift
│   ├── Components/
│   │   ├── RoomDataView.swift
│   │   └── ProbabilityRow.swift
│   └── Helpers/
│       └── FormattingHelpers.swift
└── Tests/
    ├── BayesCalculatorTests/
    └── BayesCalculatorUITests/
```

This SwiftUI application implements a Bayesian probability calculator that analyzes the likelihood of a phone's location based on noise occurrence. It demonstrates the practical application of Bayes' Theorem through an interactive interface that allows users to input and edit room data, visualize probabilities, and save different scenarios. The app follows the MVVM (Model-View-ViewModel) architectural pattern and implements real-time input validation.

### Features
- Interactive data input for room observations
- Real-time Bayesian probability calculations
- Educational view explaining Bayesian concepts
- Input validation and error handling
- Consistent number formatting
- Accessibility support

### Planned Enhancements
- Visualization of probabilities using charts
- Saving different scenarios
- Additional UI/UX improvements

### Built With
- SwiftUI
- Swift 6.0
- MVVM Architecture

### Development
- Created: December 12, 2024
- Project: ATS
- Tutor: Anthropic's AI Claude


