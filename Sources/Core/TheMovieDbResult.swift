//
//  TheMovieDbResult.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 05/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public enum TheMovieDbResult<TModelResult: TheMovieDbModelProtocol> {
    case success(TModelResult)
    case failure(NSError)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: TModelResult? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: NSError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}