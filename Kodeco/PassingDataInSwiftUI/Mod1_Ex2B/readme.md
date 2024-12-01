 A more maintainable app structure


 ```mermaid
flowchart TD
    A[PDSUI_ModuleOne_Ex2App] -->|Initializes entries array| B[ContentView]
    B -->|Passes single entry| C[FinancialEntryRow]
    
    subgraph Data Model
    D[FinancialEntry Struct]
    end
    
    subgraph Views
    B
    C
    end
    
    D -->|Defines structure for| A
    D -->|Used by| B
    D -->|Displays| C
    
    style A fill:#dfd,stroke:#333
    style B fill:#dfd,stroke:#333
    style C fill:#dfd,stroke:#333
    style D fill:#dfd,stroke:#333
```
