//
//  TheMovieDb+NSDate.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public extension String {
    
    public func fromYearMonthDay()->NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.dateFromString(self)
    }
}