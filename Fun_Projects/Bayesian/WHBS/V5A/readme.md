5th Draft - Data flow chart

- - - -

'''
mermaid

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

    %% Main data flow
    CV --> BEV
    CV --> RDV
    CV --> PR
    CV <--> PC
    
    %% ViewModel interactions
    PC <--> RD
    PC --> CR
    
    %% View component relationships
    RDV <--> RD
    PR --> FH
    
    %% Helper usage
    FH --> RDV
    FH --> PR

    %% Styling
    classDef default fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef viewModel fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef models fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;
    classDef helpers fill:#fff3e0,stroke:#f57c00,stroke-width:2px;
    
    class PC viewModel;
    class RD,CR models;
    class FH helpers;

    '''
