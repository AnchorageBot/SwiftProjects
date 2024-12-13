1st Draft

- - - -

flowchart TD
    subgraph UI["User Interface Layer"]
        CV[ContentView]
        PR[ProbabilityRow]
    end

    subgraph VM["View Model Layer"]
        PC[ProbabilityCalculator]
        CR[CalculationResults]
    end

    subgraph DM["Data Model Layer"]
        RD[RoomData]
    end

    CV -->|"@StateObject"| PC
    PC -->|"@Published roomData"| CV
    PC -->|"@Published results"| CV
    CV -->|"Displays rows using"| PR
    PC -->|"Updates"| CR
    RD -->|"Array of"| PC

    classDef modelClass fill:#f9f,stroke:#333,stroke-width:2px,color:#000
    classDef viewClass fill:#bbf,stroke:#333,stroke-width:2px,color:#000
    classDef vmClass fill:#bfb,stroke:#333,stroke-width:2px,color:#000
    
    class RD modelClass
    class CV,PR viewClass
    class PC,CR vmClass

