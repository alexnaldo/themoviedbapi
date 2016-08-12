//
//  TheMovieDbConfigurationTests.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest

@testable import TheMovieDbApi


class TheMovieDbCertificationTests: TheMovieDbApiTests {

    func testcertificationMovieList() {
        
        self.createExpectation()
        
        self.api.commands.certification(.movie).execute { (result:TheMovieDbResult<TheMovieDbCertificationListModel>) in
            
            switch result {
            case .success(let model):
                //At create time we see only 15 certifications
                XCTAssert(model.items.count == 15)
            
                //test any certification
            
                let br = model.items.filter({ (model) -> Bool in
                    model.country == "BR"
                }).first
            
                XCTAssert(br != nil)
                XCTAssert(br?.certifications.count == 6)
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        
        waitExpectation()
    }
    
    func testcertificationTVList() {
        
        self.createExpectation()
        
        self.api.commands.certification(.tv).execute { (result:TheMovieDbResult<TheMovieDbCertificationListModel>) in
            
            switch result {
            case .success(let model):
                //At create time we see only 10 certifications
                XCTAssert(model.items.count == 10)
            
                //test any certification
            
                let br = model.items.filter({ (model) -> Bool in
                    model.country == "BR"
                }).first
            
                XCTAssert(br != nil)
                XCTAssert(br?.certifications.count == 6)
            case .failure(let error):
                XCTFail("\(error)")
            }
        
            self.fulfill()
        }
        
        waitExpectation()
    }
}
