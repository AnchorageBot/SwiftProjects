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
    %% Node definitions with improved contrast
    subgraph App["BayesCalculatorApp"]
        style App fill:#2d2d2d,stroke:#666,color:#fff
        CV["ContentView"]
        style CV fill:#363636,stroke:#666,color:#fff
    end

    subgraph Views["Views Layer"]
        style Views fill:#2d2d2d,stroke:#666,color:#fff
        BEV["BayesianExplanationView"]
        RDV["RoomDataView"]
        PR["ProbabilityRow"]
        style BEV fill:#363636,stroke:#666,color:#fff
        style RDV fill:#363636,stroke:#666,color:#fff
        style PR fill:#363636,stroke:#666,color:#fff
    end

    subgraph ViewModel["ViewModel Layer"]
        style ViewModel fill:#2d2d2d,stroke:#666,color:#fff
        PC["ProbabilityCalculator"]
        style PC fill:#1a3f4d,stroke:#0288d1,color:#fff
    end

    subgraph Models["Data Models"]
        style Models fill:#2d2d2d,stroke:#666,color:#fff
        RD["RoomData"]
        CR["CalculationResults"]
        style RD fill:#1e3b1e,stroke:#388e3c,color:#fff
        style CR fill:#1e3b1e,stroke:#388e3c,color:#fff
    end

    subgraph Helpers["Helper Components"]
        style Helpers fill:#2d2d2d,stroke:#666,color:#fff
        FH["FormattingHelpers"]
        style FH fill:#3d2e15,stroke:#f57c00,color:#fff
    end

    %% Connections
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

    %% Link styling
    linkStyle default stroke:#666,stroke-width:2px
