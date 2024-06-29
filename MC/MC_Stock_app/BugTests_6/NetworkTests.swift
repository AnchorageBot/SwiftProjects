//
//  NetworkTests.swift
//  MonteCarloStockTests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains network tests for the Monte Carlo Stock Price Simulator app.
// It simulates various network conditions and tests the app's behavior
// under different scenarios. These tests ensure that the app handles
// network operations gracefully, including timeouts and errors.
// We're testing hypothetical network operations like fetching initial stock prices
// or saving simulation results to a server.

import XCTest
@testable import MonteCarloStock

class NetworkTests: XCTestCase {
    
    // Simulated API endpoints
    let fetchStockDataURL = URL(string: "https://api.example.com/stock/price")!
    let saveSimulationURL = URL(string: "https://api.example.com/simulation/save")!
    
    // Timeout duration for network requests
    let timeout: TimeInterval = 5.0
    
    // Mock URLSession for network simulation
    var mockSession: URLSession!
    
    override func setUp() {
        super.setUp()
        // Create a URLSession configuration for testing
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: configuration)
    }
    
    func testFetchStockDataSuccess() {
        // Set up expectation for async test
        let expectation = XCTestExpectation(description: "Fetch stock data success")
        
        // Simulate successful response
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.fetchStockDataURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = "{\"price\": 150.00}".data(using: .utf8)!
            return (response, data)
        }
        
        // Perform network request
        let task = mockSession.dataTask(with: fetchStockDataURL) { data, response, error in
            // Check for successful response
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200, "Status code should be 200")
            
            // Parse the data
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let price = json["price"] as? Double {
                XCTAssertEqual(price, 150.00, "Fetched price should be 150.00")
            } else {
                XCTFail("Failed to parse response data")
            }
            
            expectation.fulfill()
        }
        task.resume()
        
        // Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: timeout)
    }
    
    func testSaveSimulationResults() {
        // Set up expectation for async test
        let expectation = XCTestExpectation(description: "Save simulation results")
        
        // Simulate successful response
        MockURLProtocol.requestHandler = { request in
            // Verify the request
            XCTAssertEqual(request.httpMethod, "POST", "HTTP method should be POST")
            XCTAssertEqual(request.url, self.saveSimulationURL, "URL should match saveSimulationURL")
            
            let response = HTTPURLResponse(url: self.saveSimulationURL, statusCode: 201, httpVersion: nil, headerFields: nil)!
            let data = "{\"status\": \"success\"}".data(using: .utf8)!
            return (response, data)
        }
        
        // Create sample simulation results
        let simulationResults = [
            "meanFinalPrice": 160.5,
            "lowEstimate": 140.2,
            "highEstimate": 180.8
        ]
        
        // Perform network request
        var request = URLRequest(url: saveSimulationURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: simulationResults)
        
        let task = mockSession.dataTask(with: request) { data, response, error in
            // Check for successful response
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 201, "Status code should be 201")
            
            expectation.fulfill()
        }
        task.resume()
        
        // Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: timeout)
    }
    
    func testNetworkTimeout() {
        // Set up expectation for async test
        let expectation = XCTestExpectation(description: "Network timeout")
        
        // Simulate network timeout
        MockURLProtocol.requestHandler = { request in
            Thread.sleep(forTimeInterval: self.timeout + 1)
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
        }
        
        // Perform network request
        let task = mockSession.dataTask(with: fetchStockDataURL) { data, response, error in
            // Check for timeout error
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertEqual((error as NSError?)?.code, NSURLErrorTimedOut, "Error should be timeout")
            
            expectation.fulfill()
        }
        task.resume()
        
        // Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: timeout + 2)
    }
    
    func testNetworkError() {
        // Set up expectation for async test
        let expectation = XCTestExpectation(description: "Network error")
        
        // Simulate network error
        MockURLProtocol.requestHandler = { request in
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorNetworkConnectionLost, userInfo: nil)
        }
        
        // Perform network request
        let task = mockSession.dataTask(with: fetchStockDataURL) { data, response, error in
            // Check for network error
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertEqual((error as NSError?)?.code, NSURLErrorNetworkConnectionLost, "Error should be network connection lost")
            
            expectation.fulfill()
        }
        task.resume()
        
        // Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: timeout)
    }
}

// Mock URLProtocol for simulating network responses
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
