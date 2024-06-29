//
//  NetworkTests.swift
//  MonteCarloPiTests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains network tests for the Monte Carlo Pi Estimation app.
// It simulates various network conditions and tests the app's behavior
// under different scenarios. These tests ensure that the app handles
// network operations gracefully, including timeouts and errors.

import XCTest
@testable import MonteCarloPi

class NetworkTests: XCTestCase {
    
    // Simulated API endpoint
    let testURL = URL(string: "https://api.example.com/pi")!
    
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
    
    func testSuccessfulNetworkRequest() {
        // Set up expectation for async test
        let expectation = XCTestExpectation(description: "Successful network request")
        
        // Simulate successful response
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.testURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = "{\"pi\": 3.14159}".data(using: .utf8)!
            return (response, data)
        }
        
        // Perform network request
        let task = mockSession.dataTask(with: testURL) { data, response, error in
            // Check for successful response
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200, "Status code should be 200")
            
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
        let task = mockSession.dataTask(with: testURL) { data, response, error in
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
        let task = mockSession.dataTask(with: testURL) { data, response, error in
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
