//
//  TheMovieDbConfiguration.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 04/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TheMovieDbCertificationListModel : TheMovieDbModel {
    
    public var items: [TheMovieDbCertificationModel]!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)

        self.items = json["certifications"].map({ name, json in
            return TheMovieDbCertificationModel(country: name, json: json)
        })
    }
}

public class TheMovieDbCertificationModel: TheMovieDbModel {

    public class TheMovieDbCertificationItemModel: TheMovieDbModel {
        
        public var certification: String!
        public var meaning: String!
        public var order:Int!
 
        public override func loadFromJSON( json: JSON ) {
            super.loadFromJSON(json)

            self.certification = json["certification"].string
            self.meaning = json["meaning"].string
            self.order = json["order"].int
        }
    }
    
    public var country: String!
    public var certifications = [TheMovieDbCertificationItemModel]()
    
    public required init(json: JSON) {
        super.init(json: json)
    }
    
    public convenience init(country: String, json: JSON) {
        self.init(json: json)
        self.country = country
    }
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.certifications = json.map({ name, json in
            return TheMovieDbCertificationItemModel(json: json)
        })
    }
}

public extension TheMovieDbCommands {
    public func certification(type: TheMovieDbType)-> TheMovieDbCommand {
        return TheMovieDbCommand(commandRoute:"/certification/\(type)/list", api: self.api!)
    }
}