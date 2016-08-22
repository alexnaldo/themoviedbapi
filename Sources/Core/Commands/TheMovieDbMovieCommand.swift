//
//  TheMovieDbConfiguration.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 09/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TheMovieDbCreatedByModel: TheMovieDbItemModel {
    
    public var profile_path: String!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.profile_path = json["profile_path"].stringValue
    }
}

public class TheMovieDbSeasonModel: TheMovieDbModel {
    
    public var id:Int!
    public var air_date: NSDate?
    public var episode_count: UInt!
    public var poster_path: String!
    public var season_number: UInt!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.id = json["id"].intValue
        self.air_date = json["air_date"].string?.fromYearMonthDay()
        self.episode_count = json["episode_count"].uIntValue
        self.poster_path = json["poster_path"].stringValue
        self.season_number = json["season_number"].uIntValue
    }
}

public class TheMovieDbMovieModel: TheMovieDbDiscoverModel {
    
    public var budget:Double!
    public var created_by: [TheMovieDbCreatedByModel]!
    public var episode_run_time: [Int]!
    public var genres:[TheMovieDbItemModel]!
    public var homepage: String!
    public var in_production:Bool!
    public var languages:[String]!
    public var last_air_date: NSDate?
    public var networks:[TheMovieDbItemModel]!
    public var number_of_episodes: UInt!
    public var number_of_seasons: UInt!
    public var production_companies: [TheMovieDbItemModel]!
    public var production_countries: [TheMovieDbIsoModel]!
    public var seasons: [TheMovieDbSeasonModel]!
    public var spoken_languages: [TheMovieDbIsoModel]!
    
    public var status: String!
    public var type: String!
    public var imdb_id: String!
    public var revenue:Double!
    public var runtime:Int!
    public var tagline: String!
 
    // can be included in response
    public var credits : [TheMovieDbCreditModel]!
    public var crew : [TheMovieDbCreditModel]!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.created_by = json["created_by"].map { TheMovieDbCreatedByModel(json: $1) }
        self.episode_run_time = json["episode_run_time"].map{ $1.intValue }
        self.genres = json["genres"].map { TheMovieDbItemModel(json: $1) }
        self.homepage = json["homepage"].stringValue
        self.in_production = json["in_production"].boolValue
        self.languages = json["languages"].map { $1.stringValue }
        self.last_air_date = json["last_air_date"].string?.fromYearMonthDay()
        self.networks = json["networks"].map { TheMovieDbItemModel(json: $1) }
        self.number_of_episodes = json["number_of_episodes"].uIntValue
        self.number_of_seasons = json["number_of_seasons"].uIntValue
        self.production_companies = json["production_companies"].map { TheMovieDbItemModel(json: $1) }
        self.seasons = json["seasons"].map { TheMovieDbSeasonModel(json: $1) }
        self.status = json["status"].stringValue
        self.type = json["type"].stringValue
        self.imdb_id = json["imdb_id"].stringValue
        self.budget = json["budget"].doubleValue
        self.production_countries = json["production_countries"].map { TheMovieDbIsoModel(json: $1) }
        self.revenue = json["revenue"].doubleValue
        self.runtime = json["runtime"].intValue
        self.tagline = json["tagline"].stringValue
        self.spoken_languages = json["spoken_languages"].map { TheMovieDbIsoModel(json: $1) }
        // if credits appended to response
        self.credits = json["credits"]["cast"].map { TheMovieDbCreditModel(json: $1) }
        self.crew = json["credits"]["crew"].map { TheMovieDbCreditModel(json: $1) }
    }
}

public extension TheMovieDbParameter {
    
    public static func append_to_response(value value: [TheMovieDbAppendToResponseMovie])-> TheMovieDbParameter {
        var comma = ""
        var append = ""
        for item in value {
            append = "\(comma)\(item)"
            comma = ","
        }
        return TheMovieDbParameter(name : "append_to_response", value: append)
    }
}

public enum TheMovieDbAppendToResponseMovie : String   {
    case credits
    case images
    case keywords
    case videos
    case translations
    case reviews
    case ratings
}

public enum TheMovieDbTvOption: String {
    case latest
    case on_the_air
    case airing_today
    case top_rated
    case popular
}

public enum TheMovieDbMovieOption: String {
    case latest
    case now_playing
    case popular
    case top_rated
    case upcoming
}

public extension TheMovieDbCommands {
    
    public func tv(id: Int)-> TheMovieDbCommand {
        return detail(.tv, id: id)
    }
    
    public func movie(id: Int)-> TheMovieDbCommand {
        return detail(.movie, id: id)
    }
    
    public func detail(type: TheMovieDbType, id: Int)-> TheMovieDbCommand {
        return TheMovieDbCommand(commandRoute:"/\(type)/\(id)", api: self.api!)
    }
    
    public func tv(option: TheMovieDbTvOption)-> TheMovieDbCommand {
        return TheMovieDbCommand(commandRoute:"/tv/\(option)", api: self.api!)
    }
    
    public func movie(option: TheMovieDbMovieOption)-> TheMovieDbCommand {
        return TheMovieDbCommand(commandRoute:"/movie/\(option)", api: self.api!)
    }
}