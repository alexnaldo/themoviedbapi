//
//  TheMovieDbApiOptions.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public class TheMovieDbOptions {
    
    public var baseUrl: String = "https://api.themoviedb.org/3"
    public var apiKey: String
    public weak var delegate: TheMovieDbDelegate!
    
    public required init(apiKey: String) {
        self.apiKey =  apiKey
    }
    
    public convenience init(apiKey: String, baseUrl: String) {
        self.init(apiKey: apiKey)
        
        self.baseUrl = baseUrl
    }
}