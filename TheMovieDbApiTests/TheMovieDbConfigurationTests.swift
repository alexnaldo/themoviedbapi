//
//  TheMovieDbConfigurationTests.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest

@testable import TheMovieDbApi


class TheMovieDbConfigurationTests: TheMovieDbApiTests {

    func testInitWithApiKeyAndDefaultBaseUrl() {
        
        let api = TheMovieDbApi.configure(apiKey: self.api.options.apiKey)
        XCTAssert(api.options.apiKey == self.api.options.apiKey)
        XCTAssert(api.options.baseUrl == "https://api.themoviedb.org/3")
    }
    
    func testAutomaticSetConfiguration() {
        
        self.createExpectation()
        
        let api = TheMovieDbApi.configure(apiKey: self.api.options.apiKey)
        api.commands.configuration().execute { (result:TheMovieDbResult<TheMovieDbConfigurationModel>) in
            switch result {
                case .success:
                    XCTAssert(api.configuration != nil)
                    XCTAssert(api.configuration.image_url == "http://image.tmdb.org/t/p/")
                    XCTAssert(api.configuration.image_secure_base_url == "https://image.tmdb.org/t/p/")
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        self.waitExpectation()
    }
    
    func testLoadConfigurationSizes() {
        
        self.createExpectation()
        
        self.api.commands.configuration().execute { (result:TheMovieDbResult<TheMovieDbConfigurationModel>) in
            
            switch result {
            case .success(let model):
                XCTAssert(model.backdrop_sizes.count == 4)
                XCTAssert(model.logo_sizes.count == 7)
                XCTAssert(model.poster_sizes.count == 7)
                XCTAssert(model.profile_sizes.count == 4)
                XCTAssert(model.still_sizes.count == 4)
                XCTAssert(model.change_keys.count == 53)
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        self.waitExpectation()
    }
    
    func testResultWithError(){
        let api = TheMovieDbApi.configure(apiKey: "123456")
        self.createExpectation()
        api.commands.configuration().execute { (result:TheMovieDbResult<TheMovieDbConfigurationModel>) in
            
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssert(error.code == 7)
                XCTAssert(error.localizedDescription == "Invalid API key: You must be granted a valid key.")
            }
            
            self.fulfill()
        }
        self.waitExpectation()
    }

    func testDelegateLog(){
        
        //*** Local Logger
        class LocalLogger : TheMovieDbDelegate {
            
            private var test: TheMovieDbConfigurationTests!
            init( test: TheMovieDbConfigurationTests) {
                self.test = test
            }
            
            func logFailure(error: NSError) {
                test.fulfill()
            }
        }
        //****
        let options = TheMovieDbOptions(apiKey:  "12345")
        let log = LocalLogger(test: self)
        options.delegate = log
        //Test
        let api = TheMovieDbApi.configure(options:options)
        self.createExpectation()
        api.commands.configuration().execute { (result:TheMovieDbResult<TheMovieDbConfigurationModel>) in
            //fullfil() called on LocalLogger
        }
        self.waitExpectation()
    }
}
