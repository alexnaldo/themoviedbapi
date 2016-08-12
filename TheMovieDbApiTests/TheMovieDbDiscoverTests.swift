//
//  TheMovieDbConfigurationTests.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest

@testable import TheMovieDbApi


class TheMovieDbDiscoverTests: TheMovieDbApiTests {

    /* test movies values in 2015 */
    func testDiscoverMovieList2015() {
        
        self.createExpectation()
        
        self.api.commands.discover(.movie).execute([TheMovieDbParameter.year(value: 2015)]) { (result:TheMovieDbResult<TheMovieDbDiscoverListModel>) in
            
            switch result {
            case .success(let model):

                XCTAssert(model.page == 1)
                XCTAssert(model.total_results > 12250)
                XCTAssert(model.total_pages > 613)


            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        
        waitExpectation(7.0)
    }
    
    /* test next page */
    func testDiscoverMovieListNextPage2015() {
        
        self.createExpectation()
        
        let command = self.api.commands.discover(.movie)
        command.execute([TheMovieDbParameter.year(value: 2015)]) { (result:TheMovieDbResult<TheMovieDbDiscoverListModel>) in
            
            switch result {
            case .success(_):
                
                command.nextPage{ (result:TheMovieDbResult<TheMovieDbDiscoverListModel>) in
                    
                    XCTAssert(command.page == 2)
                    
                    switch result {
                        case .success(let model):
                            
                            XCTAssert(model.page == 2)
                            XCTAssert(model.total_results > 12250)
                            XCTAssert(model.total_pages > 613)
                        
                        case .failure(let error):
                            XCTFail("\(error)")
                    }
                    
                    self.fulfill()
                }
                
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
        
        waitExpectation(7.0)
    }
    
    /* test discover for any title example: Mad Max: Fury Road */
    func testDiscoverMovieMadMaxFuryRoad() {
        
        self.createExpectation()
        
        self.api.commands.discover(.movie).execute([TheMovieDbParameter.year(value: 2015)]) { (result:TheMovieDbResult<TheMovieDbDiscoverListModel>) in
            
            switch result {
            case .success(let model):
                
            // Mad Max: Fury Road was released in 2015
                
            let madMax = model.items.filter { $0.title == "Mad Max: Fury Road" }.first
            XCTAssert(madMax != nil)
            XCTAssert(madMax?.id == 76341)
            XCTAssert(madMax?.poster_path == "/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")
            XCTAssert(madMax?.adult == false)
            XCTAssert(madMax?.original_title == "Mad Max: Fury Road")
            XCTAssert(madMax?.original_language == "en")
            XCTAssert(madMax?.backdrop_path == "/tbhdm8UJAb4ViCTsulYFL3lxMCd.jpg")
            XCTAssert(madMax?.discoveryType == .movie)
            //tv properties
            XCTAssert(madMax?.name == nil)
            XCTAssert(madMax?.original_name == nil)
            XCTAssert(madMax?.first_air_date == nil)
            XCTAssert(madMax?.origin_country.count == 0)
                
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        
        waitExpectation(7.0)
    }
    
    /* test discover tv any title example: Mr. Robot */
    func testDiscoverTv() {
        
        self.createExpectation()
        
        self.api.commands.discover(.tv).execute{ (result:TheMovieDbResult<TheMovieDbDiscoverListModel>) in
            
            switch result {
            case .success(let model):
                
                let mrRobot = model.items.filter { $0.name == "Mr. Robot" }.first
                XCTAssert(mrRobot != nil)
                XCTAssert(mrRobot?.id == 62560)
                XCTAssert(mrRobot?.poster_path == "/esN3gWb1P091xExLddD2nh4zmi3.jpg")
                XCTAssert(mrRobot?.adult == false)
                XCTAssert(mrRobot?.original_name == "Mr. Robot")
                XCTAssert(mrRobot?.original_language == "en")
                XCTAssert(mrRobot?.backdrop_path == "/v8Y9yurHuI7MujWQMd8iL3Gy4B5.jpg")
                XCTAssert(mrRobot?.discoveryType == .tv)
                //movie properties
                XCTAssert(mrRobot?.title != nil)
                XCTAssert(mrRobot?.original_title != nil)
                XCTAssert(mrRobot?.release_date != nil)
                XCTAssert(mrRobot?.origin_country.first == "US")
                
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        
        waitExpectation(7.0)
    }
}
