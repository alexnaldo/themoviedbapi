//
//  SpecialEnum.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 04/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

//MARK: Special enum like structure with optional code (unkown)

public protocol EnumRawValueProtocol {
    init?(rawValue:String)
}

public struct SpecialEnum<EnumType: EnumRawValueProtocol> {
    
    let value: EnumType
    let rawValue : String
    
    public init?(rawValue: String) {
        guard let value = EnumType(rawValue: rawValue) else { return nil }
        self.rawValue = rawValue
        self.value = value
    }
    
    private init(rawValue: String, value:String) {
        self.value = EnumType(rawValue: rawValue)!
        self.rawValue = value
    }
    
    //Warning: Remeber to add 'case unkown' for your enum
    public static func unkown(rawValue rawValue:String)->SpecialEnum<EnumType> {
        return SpecialEnum(rawValue: "unkown", value: rawValue)
    }
}