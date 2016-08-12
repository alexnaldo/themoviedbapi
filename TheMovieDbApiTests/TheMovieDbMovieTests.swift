//
//  TheMovieDbConfigurationTests.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import XCTest

@testable import TheMovieDbApi


class TheMovieDbMovieTests: TheMovieDbApiTests {

    /* test movie */
    func testMovieMadMax() {
        
        self.createExpectation()
        
        self.api.commands.movie(76341).execute { (result:TheMovieDbResult<TheMovieDbMovieModel>) in
            
            switch result {
            case .success(let model):
                
                XCTAssert(model.id == 76341)
                XCTAssert(model.poster_path == "/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")
                XCTAssert(model.adult == false)
                XCTAssert(model.title == "Mad Max: Fury Road")
                XCTAssert(model.original_title == "Mad Max: Fury Road")
                XCTAssert(model.original_language == "en")
                XCTAssert(model.backdrop_path == "/tbhdm8UJAb4ViCTsulYFL3lxMCd.jpg")
                XCTAssert(model.discoveryType == .movie)
                XCTAssert(model.budget == 150000000)
                XCTAssert(model.runtime == 120)
                XCTAssert(model.genres.count == 4 )
                XCTAssert(model.homepage == "http://www.madmaxmovie.com/")
                XCTAssert(model.imdb_id == "tt1392190")
                XCTAssert(model.production_companies.count == 2 )
                XCTAssert(model.production_companies[0].id == 79 )
                XCTAssert(model.production_companies[0].name == "Village Roadshow Pictures")
                XCTAssert(model.production_companies[1].id == 2537 )
                XCTAssert(model.production_companies[1].name == "Kennedy Miller Productions")
                
                XCTAssert(model.production_countries.count == 2 )
                XCTAssert(model.production_countries[0].isoCode == "iso_3166_1" )
                XCTAssert(model.production_countries[0].iso == "AU")
                XCTAssert(model.production_countries[0].name == "Australia")
                XCTAssert(model.production_countries[1].isoCode == "iso_3166_1" )
                XCTAssert(model.production_countries[1].iso == "US")
                XCTAssert(model.production_countries[1].name == "United States of America")
                
                XCTAssert(model.spoken_languages.count == 1 )
                XCTAssert(model.spoken_languages[0].isoCode == "iso_639_1" )
                XCTAssert(model.spoken_languages[0].iso == "en")
                XCTAssert(model.spoken_languages[0].name == "English")
                
                XCTAssert(model.status == "Released")
                XCTAssert(model.tagline == "What a Lovely Day.")


            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        
        waitExpectation(7.0)
    }
    
    /* test tv */
    func testTvOnceUponTime() {
        
        self.createExpectation()
        
        self.api.commands.tv(39272).execute { (result:TheMovieDbResult<TheMovieDbMovieModel>) in
            
            switch result {
            case .success(let model):
                
                XCTAssert(model.id == 39272)
                XCTAssert(model.created_by.count == 2)
                XCTAssert(model.created_by[0].id == 1214366 )
                XCTAssert(model.created_by[0].name == "Edward Kitsis")
                XCTAssert(model.created_by[0].profile_path == "/48nVqw5JfC2bYmHtgLh1fQpdsKC.jpg")
                XCTAssert(model.episode_run_time.count == 2)
                XCTAssert(model.in_production)
                XCTAssert(model.languages.count == 1)
                XCTAssert(model.name == "Once Upon a Time")
                XCTAssert(model.networks.count == 1)
                XCTAssert(model.origin_country.count == 1)
                XCTAssert(model.seasons.count > 5)
                XCTAssert(model.poster_path == "/wBfEtXcnXtw5VJwChYU82CG6Att.jpg")
                XCTAssert(model.adult == false)
                XCTAssert(model.title == "Once Upon a Time")
                XCTAssert(model.original_title == "Once Upon a Time")
                XCTAssert(model.original_language == "en") //
                XCTAssert(model.backdrop_path == "/AiA82dMdt9KLEYEU7e4NRQIumg5.jpg")
                XCTAssert(model.discoveryType == .tv)
                XCTAssert(model.genres.count == 3 )
                XCTAssert(model.homepage == "http://abc.go.com/shows/once-upon-a-time")
                XCTAssert(model.production_companies.count == 1 )
                XCTAssert(model.production_companies[0].id == 19366 )
                XCTAssert(model.production_companies[0].name == "ABC Studios")
                XCTAssert(model.type == "Scripted")
                
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        
        waitExpectation(7.0)
    }
    
    /* test tv credits */
    func testTvOnceUponTimeCredits() {
        
        self.createExpectation()
        
        let parameter = TheMovieDbParameter.append_to_response(value: [TheMovieDbAppendToResponseMovie.credits])
        self.api.commands.tv(39272).appendToParameter(parameter).execute { (result:TheMovieDbResult<TheMovieDbMovieModel>) in
            
            switch result {
            case .success(let model):
                
                XCTAssert(model.credits != nil)
                XCTAssert(model.credits.count > 1)
                
                let credit = model.credits.first!
                XCTAssert(credit.character == "Mary Margaret Blanchard / Snow White")
                XCTAssert(credit.credit_id == "5258efa4760ee346618f02c8")
                XCTAssert(credit.id == 417)
                XCTAssert(credit.name == "Ginnifer Goodwin")
                XCTAssert(credit.profile_path == "/vAH6j1A0L88R4UD9QX1nM9OLoYw.jpg")
                XCTAssert(credit.order == 0)
                
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            self.fulfill()
        }
        
        waitExpectation(7.0)
    }
    
}
