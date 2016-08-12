//
//  TheMovieDbApiTests.swift
//  TheMovieDbApiTests
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest

@testable import TheMovieDbApi

class TheMovieDbApiTests: XCTestCase {
    
    var api:TheMovieDbApi!
    
    override func setUp() {
        api = TheMovieDbApi.configure(apiKey: "1d3a19c4302b7225834283260b923e20")
    }
    
    private var expectation: XCTestExpectation!
    
    func createExpectation() {
        expectation  = self.expectationWithDescription("Testing async \(self)")
    }
    
    func fulfill() {
        self.expectation.fulfill()
    }
    
    func waitExpectation(timeout: NSTimeInterval = 5.0) {
        self.waitForExpectationsWithTimeout(timeout) { error in
            if error != nil {
                XCTFail("Expectation Failed for tests \(self) with error: \(error)");
            }
        }
    }
}
