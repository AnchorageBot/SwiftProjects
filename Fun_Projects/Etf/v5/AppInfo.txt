# ETF Portfolio Analyzer v5 - App Information

## Overview
ETF Portfolio Analyzer is a SwiftUI-based iOS application that helps investors analyze their ETF portfolio performance. The app calculates individual ETF returns, expenses, and provides a comprehensive portfolio summary with weighted performance metrics.

## High-Level Summary

### Purpose
The app enables users to:
- Track multiple ETF investments (up to 10)
- Calculate total returns including capital appreciation and dividend yield
- Account for expense ratios
- View annualized performance metrics
- Analyze portfolio allocation and weighted returns

### Key Features
1. **Direct Numeric Input** - Enter investment data without string conversion complexity
2. **Real-time Validation** - Instant feedback on input completeness
3. **Unified Results View** - All results on a single, scrollable page
4. **Expandable Details** - Click any ETF for detailed breakdown
5. **Share Functionality** - Export analysis as formatted text report

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                          USER INPUT                              │
│                                                                  │
│  1. Number of ETFs (Stepper)                                   │
│  2. For each ETF:                                              │
│     - Name (TextField)                                          │
│     - Expense Ratio % (TextField with NumberFormatter)         │
│     - Annual Yield % (TextField with NumberFormatter)          │
│     - Shares (TextField with NumberFormatter)                  │
│     - Purchase Price $ (TextField with NumberFormatter)        │
│     - Purchase Date (DatePicker)                              │
│     - Current Price $ (TextField with NumberFormatter)         │
│     - Analysis Date (DatePicker)                              │
└────────────────────────────┬───────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      ContentView                                 │
│                                                                  │
│  - Owns PortfolioViewModel (@StateObject)                      │
│  - Controls input/results display (@State showingResults)      │
│  - Triggers analysis when "Analyze Portfolio" pressed          │
└────────────────────────────┬───────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                   PortfolioViewModel                             │
│                                                                  │
│  Published Properties:                                           │
│  - @Published etfInputs: [ETFInput]                            │
│  - @Published individualResults: [ETFAnalysisResult]           │
│  - @Published portfolioSummary: PortfolioSummaryResult?        │
│  - @Published numberOfETFs: Int                                │
│                                                                  │
│  Methods:                                                        │
│  - analyze() → Triggers calculation                            │
│  - clearAll() → Resets all data                               │
└────────────────────────────┬───────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                   PortfolioCalculator                            │
│                                                                  │
│  Pure Functions:                                                 │
│  1. analyzeETF(ETFInput) → ETFAnalysisResult?                  │
│     - Calculates days held                                      │
│     - Calculates capital appreciation                          │
│     - Calculates yield income                                  │
│     - Calculates expenses                                      │
│     - Calculates annualized returns                           │
│                                                                  │
│  2. analyzePortfolio([ETFAnalysisResult]) → PortfolioSummary   │
│     - Sums all individual metrics                              │
│     - Calculates weighted returns                              │
│     - Determines portfolio allocation %                        │
└────────────────────────────┬───────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    UnifiedResultsView                            │
│                                                                  │
│  Displays:                                                       │
│  1. Portfolio Summary Card                                       │
│     - Total invested, current value                            │
│     - Net return, annual return                                │
│     - Allocation breakdown                                      │
│                                                                  │
│  2. Individual ETF Result Cards                                 │
│     - Summary always visible                                    │
│     - Detailed breakdown on tap (expandable)                   │
│                                                                  │
│  3. Share Report Function                                       │
│     - Generates text summary for export                        │
└─────────────────────────────────────────────────────────────────┘
```

## Architecture Pattern

### MVVM (Model-View-ViewModel)
- **Models**: ETFInput, ETFAnalysisResult, PortfolioSummaryResult
- **View Model**: PortfolioViewModel (ObservableObject)
- **Views**: ContentView, PortfolioInputSection, UnifiedResultsView
- **Calculator**: PortfolioCalculator (Business Logic)

## Key Calculations

### Individual ETF Metrics
1. **Capital Appreciation** = (Current Price - Purchase Price) × Shares
2. **Yield Income** = Initial Investment × Annual Yield % × Years Held
3. **Total Gross Return** = Capital Appreciation + Yield Income
4. **Expenses** = Initial Investment × Expense Ratio % × Years Held
5. **Net Return** = Gross Return - Expenses
6. **Annualized Return** = ((Final Value / Initial Value)^(365/Days Held)) - 1

### Portfolio Metrics
1. **Total Values** = Sum of all individual ETF values
2. **Weighted Annual Return** = Sum of (ETF Return × ETF Weight)
3. **ETF Weight** = ETF Initial Investment / Total Initial Investment
4. **Allocation %** = ETF Current Value / Total Current Value × 100

## State Management

### View State
- `showingResults`: Boolean controlling input/results display
- `expandedETFs`: Set<UUID> tracking which ETF details are expanded

### Data State (in ViewModel)
- `numberOfETFs`: Controls size of input array
- `etfInputs`: Array of user inputs
- `individualResults`: Calculated results per ETF
- `portfolioSummary`: Aggregate portfolio metrics

## Validation Rules
An ETF input is valid when:
- Name is not empty
- Expense ratio ≥ 0
- Annual yield ≥ 0
- Shares > 0
- Start price > 0
- End price > 0
- End date ≥ Start date

## Development Team
- Original Development: ATS Project
- AI Assistance: Google Gemini Advanced 2.5 Pro
- v3-v5 Refactoring: Claude (Anthropic)
- Created: May 21, 2025
- Latest Update: May 26, 2025

## Technical Stack
- **Language**: Swift 6.0
- **Framework**: SwiftUI
- **Minimum iOS**: 16.0 (NavigationStack)
- **Architecture**: MVVM
- **State Management**: Combine + ObservableObject
