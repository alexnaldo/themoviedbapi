//
//  TheMovieDbConfiguration.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 09/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TheMovieDbCreditModel: TheMovieDbItemModel {
    
    public var character: String!
    public var credit_id: String!
    public var profile_path: String!
    public var order: Int!
    // for movie
    public var cast_id: Int!
    // for crew
    public var department: String!
    public var job: String!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.character = json["character"].stringValue
        self.credit_id = json["credit_id"].stringValue
        self.profile_path = json["profile_path"].stringValue
        self.order = json["order"].intValue
        self.cast_id = json["cast_id"].intValue
        self.department = json["department"].stringValue
        self.job = json["job"].stringValue
    }
}