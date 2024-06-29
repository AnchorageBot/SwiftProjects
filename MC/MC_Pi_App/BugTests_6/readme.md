Network Testing:

* Test your app's behavior with various network conditions
* Use tools like Charles Proxy to simulate different scenarios

- - - -

# Monte Carlo Pi Estimation App - Network Testing Guide

This guide provides instructions on how to perform network testing for the Monte Carlo Pi Estimation app using Xcode and Charles Proxy.

## Setting Up Network Tests

1. Open your Xcode project for the Monte Carlo Pi Estimation app.

2. Create a new file in your test target:
   - Right-click on your test target in the project navigator
   - Select "New File"
   - Choose "Swift File"
   - Name it "NetworkTests.swift"

3. Copy the provided NetworkTests code into this new file.

4. Ensure your test target is set up correctly:
   - Select your project in the project navigator
   - Choose your test target
   - In the "General" tab, make sure your app target is listed under "Target Dependencies"

## Running Network Tests in Xcode

1. To run all network tests:
   - Use the keyboard shortcut `Cmd + U`
   - Or go to Product > Test in the Xcode menu

2. To run a specific test:
   - Click the diamond-shaped icon next to the test function you want to run

3. To run tests in the NetworkTests file:
   - Right-click on the NetworkTests.swift file in the project navigator
   - Select "Run 'NetworkTests'" from the context menu

## Interpreting Test Results

- Green checkmark: The test passed
- Red X: The test failed
- Gray diamond: The test didn't run

### Common Issues and Their Meanings

1. If `testSuccessfulNetworkRequest` fails:
   - Your app may not be handling successful responses correctly
   - Check your JSON parsing and data handling code

2. If `testNetworkTimeout` fails:
   - Your app may not be handling timeouts gracefully
   - Ensure you have proper timeout handling and user feedback for slow connections

3. If `testNetworkError` fails:
   - Your app may not be handling network errors properly
   - Review your error handling code and user feedback for connection issues

## Using Charles Proxy for Advanced Network Testing

1. Download and install Charles Proxy from https://www.charlesproxy.com/

2. Configure your iOS simulator or device to use Charles Proxy:
   - In iOS Settings, go to Wi-Fi > Configure Proxy > Manual
   - Set the server to your computer's IP address
   - Set the port to 8888 (Charles default)

3. In Charles Proxy:
   - To simulate slow networks: Tools > Throttle Settings
   - To simulate delays: Right-click a request > Breakpoints
   - To modify responses: Tools > Rewrite

4. Run your app on the simulator or device and observe its behavior under different network conditions.

## Responding to Test Results

1. If tests reveal issues with timeout handling:
   - Implement a timeout mechanism in your network requests
   - Add user feedback for slow connections (e.g., loading indicators)

2. If error handling tests fail:
   - Enhance your error handling code
   - Provide meaningful error messages to users

3. If JSON parsing is problematic:
   - Review and refactor your JSON decoding logic
   - Consider using Codable for more robust parsing

4. For any failures related to specific network conditions:
   - Use Charles Proxy to replicate the condition
   - Debug your app's behavior in real-time

5. After making changes:
   - Re-run the network tests
   - Test manually using Charles Proxy to ensure improvements

Remember to regularly run these network tests, especially after making changes to your app's networking code or when preparing for a new release.
