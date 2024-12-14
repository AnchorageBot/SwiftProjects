5th Draft - Data flow chart

- - - -

# BayesCalculator

A SwiftUI app that demonstrates Bayesian probability calculations through an interactive phone location example.

## Overview

This app helps users understand Bayesian probability by solving a practical problem: determining the likely location of a phone based on noise observations. Users can input observation data for different rooms and see how probabilities update based on new evidence.

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture with unidirectional data flow:

```mermaid
flowchart TB
    subgraph App["BayesCalculatorApp"]
        CV[ContentView]
    end

    subgraph Views["Views Layer"]
        BEV[BayesianExplanationView]
        RDV[RoomDataView]
        PR[ProbabilityRow]
    end

    subgraph ViewModel["ViewModel Layer"]
        PC[ProbabilityCalculator]
    end

    subgraph Models["Data Models"]
        RD[RoomData]
        CR[CalculationResults]
    end

    subgraph Helpers["Helper Components"]
        FH[FormattingHelpers]
    end

    CV --> BEV
    CV --> RDV
    CV --> PR
    CV <--> PC
    PC <--> RD
    PC --> CR
    RDV <--> RD
    PR --> FH
    FH --> RDV
    FH --> PR

    classDef default fill:#f9f9f9,stroke:#333,stroke-width:2px
    classDef viewModel fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    classDef models fill:#e8f5e9,stroke:#388e3c,stroke-width:2px
    classDef helpers fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    
    class PC viewModel
    class RD,CR models
    class FH helpers
