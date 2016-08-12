//
//  TheMovieDbConfiguration.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum BackdropSizeEnum : String, EnumRawValueProtocol {
    case unkown  /* for error */
    case w300
    case w780
    case w1280
    case original
}
public typealias BackdropSize = SpecialEnum<BackdropSizeEnum>

public enum LogoSizeEnum : String, EnumRawValueProtocol {
    case unkown /* for error */
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}
public typealias LogoSize = SpecialEnum<LogoSizeEnum>


public enum PosterSizeEnum : String, EnumRawValueProtocol {
    case unkown /* for error */
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}
public typealias PosterSize = SpecialEnum<PosterSizeEnum>


public enum ProfileSizeEnum : String, EnumRawValueProtocol {
    case unkown /* for error */
    case w45
    case w185
    case h632
    case original
}
public typealias ProfileSize = SpecialEnum<ProfileSizeEnum>


public enum StillSizeEnum : String, EnumRawValueProtocol {
    case unkown /* for error */
    case w92
    case w185
    case w300
    case original
}
public typealias StillSize = SpecialEnum<StillSizeEnum>


public enum ChangeKeyEnum : String, EnumRawValueProtocol {
    case unkown /* for error */
    case adult
    case air_date
    case also_known_as
    case alternative_titles
    case biography
    case birthday
    case budget
    case cast
    case certifications
    case character_names
    case created_by
    case crew
    case deathday
    case episode
    case episode_number
    case episode_run_time
    case freebase_id
    case freebase_mid
    case general
    case genres
    case guest_stars
    case homepage
    case images
    case imdb_id
    case languages
    case name
    case network
    case origin_country
    case original_name
    case original_title
    case overview
    case parts
    case place_of_birth
    case plot_keywords
    case production_code
    case production_companies
    case production_countries
    case releases
    case revenue
    case runtime
    case season
    case season_number
    case season_regular
    case spoken_languages
    case status
    case tagline
    case title
    case translations
    case tvdb_id
    case tvrage_id
    case type
    case video
    case videos
}
public typealias ChangeKey = SpecialEnum<ChangeKeyEnum>

public class TheMovieDbConfigurationModel: TheMovieDbModel {
    
    public var image_url: String!
    public var image_secure_base_url: String!
    
    public var backdrop_sizes = [BackdropSize]()
    public var logo_sizes = [LogoSize]()
    public var poster_sizes = [PosterSize]()
    public var profile_sizes = [ProfileSize]()
    public var still_sizes = [StillSize]()
    public var change_keys = [ChangeKey]()
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.image_url = json["images"]["base_url"].string
        self.image_secure_base_url = json["images"]["secure_base_url"].string
        
        self.backdrop_sizes = json["images"]["backdrop_sizes"].map({ name, json in
            guard let value = BackdropSize(rawValue: json.stringValue) else { return BackdropSize.unkown(rawValue: json.stringValue) }
            return value
        })
        self.logo_sizes = json["images"]["logo_sizes"].map({ name, json in
            guard let value = LogoSize(rawValue: json.stringValue) else { return LogoSize.unkown(rawValue: json.stringValue) }
            return value
        })
        self.poster_sizes = json["images"]["poster_sizes"].map({ name, json in
            guard let value = PosterSize(rawValue: json.stringValue) else { return PosterSize.unkown(rawValue: json.stringValue) }
            return value
        })
        self.profile_sizes = json["images"]["profile_sizes"].map({ name, json in
            guard let value = ProfileSize(rawValue: json.stringValue) else { return ProfileSize.unkown(rawValue: json.stringValue) }
            return value
        })
        self.still_sizes = json["images"]["still_sizes"].map({ name, json in
            guard let value = StillSize(rawValue: json.stringValue) else { return StillSize.unkown(rawValue: json.stringValue) }
            return value
        })
        self.change_keys = json["change_keys"].map({ name, json in
            guard let value = ChangeKey(rawValue: json.stringValue) else { return ChangeKey.unkown(rawValue: json.stringValue) }
            return value
        })
    }
}

public extension TheMovieDbCommands {

    public func configuration()-> TheMovieDbCommand {
        return TheMovieDbCommand(commandRoute:"/configuration", api: self.api!)
    }
}

