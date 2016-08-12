//
//  TheMovieDbParameterTests.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest
@testable import TheMovieDbApi

class TheMovieDbParameterTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testParameterNameWithoutValue() {
        let parameter = TheMovieDbParameter(name: "the name")
        XCTAssert(parameter.name == "the name")
        XCTAssert(parameter.value == nil)
    }
    
    func testParameterValue() {
        var parameter = TheMovieDbParameter(name: "",value: "the value")
        XCTAssert(parameter.value == "the value")
        parameter = TheMovieDbParameter(name: "",value: nil)
        XCTAssert(parameter.value == nil)
    }
}
