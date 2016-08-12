//
//  TheMovieDbDelegate.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public protocol TheMovieDbDelegate : class {
    func logFailure(error: NSError)
    func logConnectionFailure(error: NSError)
}

public extension TheMovieDbDelegate {
    func logFailure(error: NSError) {
        print(error)
    }
    func logConnectionFailure(error: NSError) {
        print(error)
    }
}