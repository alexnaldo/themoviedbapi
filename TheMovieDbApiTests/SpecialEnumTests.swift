//
//  SpecialEnumTests.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 04/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest
@testable import TheMovieDbApi

enum SpecialMockEnum : String, EnumRawValueProtocol {
    case unkown  /* for error */
    case item1
    case item2
}

typealias SpecialMock = SpecialEnum<SpecialMockEnum>

class SpecialEnumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithValueExists() {
        let value = SpecialMock(rawValue: "item1")
        XCTAssert(value  != nil)
        XCTAssert(value?.rawValue == "item1")
        XCTAssert(value?.value == SpecialMockEnum.item1)
    }
    
    func testInitWithInvalidValue() {
        let value = SpecialMock(rawValue: "item3")
        XCTAssert(value  == nil)
    }
    
    func testInitWithUnkownRawValue() {
        let value = SpecialMock.unkown(rawValue: "item3")
        XCTAssert(value.value == SpecialMockEnum.unkown)
        XCTAssert(value.rawValue ==  "item3")

    }
}
