//
//  TheMovieDbParameterTests.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest
@testable import TheMovieDbApi

class TheMovieDbDiscoverQueryTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAloneValue() {
        
        let query = TheMovieDbDiscoverQuery.and(1)
        XCTAssert(query.description == "1")
    }
    
    func testAndValue() {
        
        let query = TheMovieDbDiscoverQuery.and(1).and(2)
        XCTAssert("\(query)" == "1;2", "\(query)")
    }
    
    func testOrValue() {
        
        let query = TheMovieDbDiscoverQuery.and(1).or(2)
        XCTAssert("\(query)" == "1|2")
    }
    
    func testAnyItemSameQuery() {
        
        let a = TheMovieDbDiscoverQuery.and(1)
        let b = a.and(2)
        
        XCTAssert("\(a)" == "1;2")
        XCTAssert("\(b)" == "1;2")
    }
}
