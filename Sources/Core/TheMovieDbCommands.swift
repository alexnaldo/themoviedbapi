//
//  TheMovieDbCommands.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public class TheMovieDbCommands {
    
    weak var api: TheMovieDbNetworkProtocol!
    internal init (api: TheMovieDbNetworkProtocol) {
        self.api = api
    }
    
    //MARK: All commands are implemented as extension
}