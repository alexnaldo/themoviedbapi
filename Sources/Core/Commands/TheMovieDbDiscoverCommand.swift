//
//  TheMovieDbConfiguration.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 04/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias TheMovieDbDiscoverListModel = TheMovieDbListModel<TheMovieDbDiscoverModel>

public class TheMovieDbDiscoverModel: TheMovieDbModel {
    
    public var poster_path: String!
    public var adult = false
    public var overview: String!
    public var release_date: NSDate?
    public var genre_ids:[Int]!
    public var id:Int!
    public var original_title:String!
    public var original_language:String!
    public var title:String!
    public var backdrop_path:String!
    public var popularity:Double!
    public var vote_count:UInt!
    public var video = false
    public var vote_average:Double!
    /* tv properties */
    public var name: String!
    public var original_name: String!
    public var origin_country:[String]!
    public var first_air_date: NSDate?
    
    public var discoveryType: TheMovieDbType {
        if let _ = self.name {
            return .tv
        } else {
            return .movie
        }
    }
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.poster_path = json["poster_path"].stringValue
        self.adult = json["adult"].boolValue
        self.overview = json["overview"].stringValue
        self.release_date = json["release_date"].string?.fromYearMonthDay()
        self.genre_ids = json["genre_ids"].map { $1.intValue }
        self.id = json["id"].intValue
        self.original_title = json["original_title"].stringValue
        self.original_language = json["original_language"].stringValue
        self.title = json["title"].stringValue
        self.backdrop_path = json["backdrop_path"].stringValue
        self.popularity = json["popularity"].doubleValue
        self.vote_count = json["vote_count"].uIntValue
        self.video = json["video"].boolValue
        self.vote_average = json["vote_average"].doubleValue
        //tv properties
        self.name = json["name"].string
        self.original_name = json["original_name"].string
        self.origin_country = json["origin_country"].map { $1.stringValue }
        self.first_air_date = json["first_air_date"].string?.fromYearMonthDay()
        //copy tv properties to movie properties to make access easy
        if self.discoveryType == .tv {
            self.title = self.name
            self.original_title = self.original_name
            self.release_date = self.first_air_date
        }
    }
}

public extension TheMovieDbCommands {
    public func discover(type: TheMovieDbType)-> TheMovieDbListCommand {
        return TheMovieDbListCommand(commandRoute:"/discover/\(type)", api: self.api!)
    }
}