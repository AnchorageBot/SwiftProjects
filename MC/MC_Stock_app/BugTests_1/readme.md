Unit Testing:

* Use [XCTest framework](https://developer.apple.com/documentation/xctest) to write unit tests
* Test individual components and functions in isolation
* Aim for high code coverage

- - - -

# Monte Carlo Stock App - Unit Testing Guide

This guide provides instructions on how to add and run unit tests for the Monte Carlo Pi Estimation app using Xcode.

## Adding Unit Tests to Your Xcode Project

1. Open your Xcode project for the Monte Carlo Stock app.

2. In Xcode, go to File > New > Target.

3. In the new target window, select "Unit Testing Bundle" under the iOS tab.

4. Click "Next" and name your test target (e.g., "MonteCarloStockTests").

5. Click "Finish" to create the new test target.

6. In the project navigator, right-click on your new test target folder.

7. Select "New File" from the context menu.

8. Choose "Swift File" and name it "MonteCarloStockTests.swift".

9. Copy the provided unit test code into this new file.

10. Ensure the import statement at the top of the file matches your main target name:
    ```swift
    @testable import YourMainTargetName
    ```

## Running the Unit Tests

1. To run all tests:
   - Use the keyboard shortcut `Cmd + U`
   - Or go to Product > Test in the Xcode menu

2. To run a specific test:
   - Click the diamond-shaped icon next to the test function you want to run

3. To run tests in a specific file:
   - Right-click on the file in the project navigator
   - Select "Run 'TestFileName'" from the context menu

## Interpreting Test Results

- Green checkmark: The test passed
- Red X: The test failed
- Gray diamond: The test didn't run

## Acting on Test Results

1. If all tests pass:
   - Your implementation is working as expected
   - You can proceed with confidence

2. If a test fails:
   - Xcode will show you which assertion failed
   - Review the error message and the line of code where the failure occurred
   - Debug your implementation to address the failing test

3. If you see unexpected results:
   - Review your test implementation to ensure it's correct
   - Consider edge cases that might not be covered

4. Iterative process:
   - Fix any issues in your main code or tests
   - Re-run the tests
   - Repeat until all tests pass

## Maintaining and Updating Tests

- As you add new features or modify existing ones, update your tests accordingly
- Regularly run your test suite to catch any regressions
- Consider adding new tests for edge cases or scenarios you hadn't previously considered

Remember, thorough testing leads to more robust and reliable code. Happy testing!

