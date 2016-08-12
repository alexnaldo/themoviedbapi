//
//  TheMovieDbModel.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol TheMovieDbModelProtocol {
    init(json: JSON)
    func loadFromJSON( json: JSON )
}

public class TheMovieDbModel: TheMovieDbModelProtocol {
    
    public required init( json: JSON ) {
        self.loadFromJSON(json)
    }
    
    public func loadFromJSON( json: JSON ) {
    }
}

public protocol TheMovieDbModelListProtocol: TheMovieDbModelProtocol {
    var page:UInt {get}
    var total_results: UInt {get}
    var total_pages: UInt {get}
}

public class TheMovieDbListModel<T:TheMovieDbModelProtocol> : TheMovieDbModel,TheMovieDbModelListProtocol {
    
    public required init( json: JSON ) {
        super.init(json: json)
    }
    
    public var page:UInt = 0
    public var total_results: UInt = 0
    public var total_pages: UInt = 0
    
    public var items: [T]!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.page = json["page"].uIntValue
        self.total_results = json["total_results"].uIntValue
        self.total_pages = json["total_pages"].uIntValue
        
        self.items = json["results"].map { T(json: $1) }
    }
}

public class TheMovieDbItemModel: TheMovieDbModel {
    
    public var id:Int!
    public var name: String!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}

public class TheMovieDbIsoModel: TheMovieDbModel {
    
    public var isoCode:String!
    public var iso:String!
    public var name: String!
    
    public override func loadFromJSON( json: JSON ) {
        super.loadFromJSON(json)
        
        for (name,json) in json {
            if name == "name" {
                self.name = json.stringValue
            } else  {
                self.isoCode = name
                self.iso = json.stringValue
            }
        }
    }
}