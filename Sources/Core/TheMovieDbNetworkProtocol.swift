//
//  TheMovieDbNetworkProtocol.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public protocol TheMovieDbNetworkProtocol: class {
    var configuration: TheMovieDbConfigurationModel! {get}
    func request<T where T: TheMovieDbModelProtocol>(command: TheMovieDbCommand, withCompletion: (result: TheMovieDbResult<T>)->Void)
    func request<T where T: TheMovieDbModelProtocol>(commandRoute: String, parameters: [TheMovieDbParameter], withCompletion: (result: TheMovieDbResult<T>)->Void)
}