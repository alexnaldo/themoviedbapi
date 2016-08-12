//
//  TheMovieDbDiscoverParameters.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation


public enum TheMovieDbCertificationCountry: String {
    case certification
    case certification_lte = "certification.lte"
}

public enum TheMovieDbFilterType: String {
    case greaterOrEqual = "gte"
    case lowerOrEqual = "lte"
}

public enum TheMovieDbSortBy: String {
    case popularity
    case release_date
    case revenue
    case primary_release_date
    case original_title
    case vote_average
    case vote_count
}

public enum TheMovieDbSortOrder: String {
    case asc
    case desc
}

/* see parameter documentation at http://docs.themoviedb.apiary.io/#reference/discover/discovermovie/get?console=1 */

public extension TheMovieDbParameter {
    
    public static func certification_country(value value: TheMovieDbCertificationCountry)-> TheMovieDbParameter {
        return TheMovieDbParameter(name : "certification_country", value: value.rawValue)
    }
    
    public static func certification(value value: String) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "certification", value: value)
    }
    
    public static func certification_lte(value value: String) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "certification.lte", value: value)
    }
    
    public static func include_adult(value value: Bool) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "include_adult", value: String(value))
    }
    
    public static func include_video(value value: Bool) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "include_video", value: String(value))
    }
    
    public static func primary_release_year(value value: Int) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "primary_release_year", value: String(value))
    }
    
    public static func primary_release_date(value value: NSDate, filter: TheMovieDbFilterType) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "primary_release_date.\(filter.rawValue)", value: value.asYearMonthDay())
    }
    
    public static func release_date(value value: NSDate, filter: TheMovieDbFilterType) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "release_date.\(filter.rawValue)", value: value.asYearMonthDay())
    }
    
    public static func sort_by(value value: TheMovieDbSortBy, order: TheMovieDbSortOrder) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "sort_by", value: "\(value.rawValue).\(order.rawValue)")
    }
    
    public static func vote_count(value value: Int, filter: TheMovieDbFilterType) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "vote_count.\(filter.rawValue)", value: String(value))
    }
    
    public static func vote_average(value value: Int, filter: TheMovieDbFilterType) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "vote_average.\(filter.rawValue)", value: String(value))
    }
    
    public static func with_cast(value value: TheMovieDbDiscoverQuery) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "with_cast", value: "\(value)")
    }
    
    public static func with_crew(value value: TheMovieDbDiscoverQuery) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "with_crew", value: "\(value)")
    }
    
    public static func with_companies(value value: TheMovieDbDiscoverQuery) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "with_companies", value: "\(value)")
    }
    
    public static func with_genres(value value: TheMovieDbDiscoverQuery) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "with_genres", value: "\(value)")
    }
    
    public static func with_keywords(value value: TheMovieDbDiscoverQuery) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "with_keywords", value: "\(value)")
    }
    
    public static func with_people(value value: TheMovieDbDiscoverQuery) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "with_people", value: "\(value)")
    }
    
    public static func year(value value: Int) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "year", value: String(value))
    }
    
    //MARK: tv properties
    
    public static func air_date(value value: NSDate, filter: TheMovieDbFilterType) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "air_date.\(filter.rawValue)", value: value.asYearMonthDay())
    }
    
    public static func first_air_date(value value: NSDate, filter: TheMovieDbFilterType) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "first_air_date.\(filter.rawValue)", value: value.asYearMonthDay())
    }
    
    public static func first_air_date_year(value value: Int) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "first_air_date_year", value: String(value))
    }
    
    public static func with_networks(value value: TheMovieDbDiscoverQuery) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "with_networks", value: "\(value)")
    }
    
    public static func timezone(value value: String) -> TheMovieDbParameter {
        return TheMovieDbParameter(name: "timezone", value: String(value))
    }
}