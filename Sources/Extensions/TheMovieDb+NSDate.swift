//
//  TheMovieDb+NSDate.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public extension NSDate {
    
    public func asYearMonthDay()->String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(self)
    }
}