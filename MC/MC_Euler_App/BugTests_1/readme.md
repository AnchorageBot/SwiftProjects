# Adding Test Files to Xcode Project

Follow these steps to add the test files to the appropriate test targets in your Xcode project for the Monte Carlo Simulation app:

## 1. Open Your Xcode Project

- Launch Xcode
- Open your Monte Carlo Simulation project

## 2. Create Unit Test Target (if not already present)

- Click on your project in the Project Navigator
- Select your project under the "PROJECT" section
- Click the "+" button under the "TARGETS" section
- Choose "Unit Testing Bundle" from the template list
- Name it "MonteCarloSimulationTests"
- Click "Finish"

## 3. Create UI Test Target (if not already present)

- Repeat the process from step 2, but choose "UI Testing Bundle"
- Name it "MonteCarloSimulationUITests"

## 4. Add MonteCarloSimulationTests.swift

- Right-click on the "MonteCarloSimulationTests" group in the Project Navigator
- Select "New File..."
- Choose "Swift File" from the template list
- Name it "MonteCarloSimulationTests"
- Ensure "MonteCarloSimulationTests" is selected as the target
- Click "Create"
- Replace the contents of the file with the provided MonteCarloSimulationTests.swift code

## 5. Add MonteCarloSimulationUITests.swift

- Right-click on the "MonteCarloSimulationUITests" group in the Project Navigator
- Select "New File..."
- Choose "Swift File" from the template list
- Name it "MonteCarloSimulationUITests"
- Ensure "MonteCarloSimulationUITests" is selected as the target
- Click "Create"
- Replace the contents of the file with the provided MonteCarloSimulationUITests.swift code

## 6. Add ContentViewIntegrationTests.swift

- Right-click on the "MonteCarloSimulationTests" group in the Project Navigator
- Select "New File..."
- Choose "Swift File" from the template list
- Name it "ContentViewIntegrationTests"
- Ensure "MonteCarloSimulationTests" is selected as the target
- Click "Create"
- Replace the contents of the file with the provided ContentViewIntegrationTests.swift code

## 7. Update Test Target Settings

- Select the "MonteCarloSimulationTests" target in your project settings
- Go to the "Build Phases" tab
- Expand "Link Binary With Libraries"
- Click the "+" button
- Add your main app target (likely named "MonteCarloSimulation")

## 8. Build and Run Tests

- Select "Product" > "Test" from the menu bar (or use the keyboard shortcut Cmd+U)
- Xcode will build your project and run all tests
- Check the test navigator to see the results of each test

## 9. Troubleshooting

If you encounter any issues:
- Ensure all necessary files are added to the correct targets
- Check that your main app target is set as a dependency for the test targets
- Verify that the `@testable import MonteCarloSimulationApp` statement in the test files matches your app's module name

By following these steps, you should have successfully added the test files to your Xcode project and be ready to run your unit tests, UI tests, and integration tests for the Monte Carlo Simulation app.
