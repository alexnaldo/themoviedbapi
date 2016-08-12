//
//  TheMovieDbParameter.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public func ==(lhs: TheMovieDbParameter, rhs: TheMovieDbParameter) -> Bool
{
    return lhs.name == rhs.name
}

public class TheMovieDbParameter {
    
    let name: String
    let value: String?
    
    public required init(name:String, value: String?){
        self.name = name
        self.value = value
    }
    
    convenience init(name: String) {
        self.init(name: name, value: nil)
    }
    
    public static func api_key(value value: String)-> TheMovieDbParameter {
        return TheMovieDbParameter(name : "api_key", value: value)
    }
    
    public static func language(value value: String) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "language", value: value)
    }
    
    public static func page(value value: UInt) -> TheMovieDbParameter {
        var page = value
        if page < 1 || page > 1000 {
            page = 1000
        }
        return TheMovieDbParameter(name: "page", value: String(page))
    }
}