//
//  TheMovieCommand.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation

public class TheMovieDbCommand {
    
    public let commantRoute: String
    public weak var api: TheMovieDbNetworkProtocol!
    public var defaultParameters = [TheMovieDbParameter]()
    
    public init(commandRoute: String, api: TheMovieDbNetworkProtocol) {
        self.commantRoute = commandRoute
        self.api = api
    }
    
    public func buildDefaultParameters()->[TheMovieDbParameter] {
        return self.defaultParameters
    }
    
    public func appendToParameter(parameter: TheMovieDbParameter) -> Self {
        self.defaultParameters.append(parameter)
        return self
    }
    
    public func execute<T:TheMovieDbModelProtocol>(withCompletion: (result: TheMovieDbResult<T>)->Void ) {
        self.execute(self.buildDefaultParameters(), withCompletion: withCompletion)
    }
    
    public func execute<T:TheMovieDbModelProtocol>( parameters: [TheMovieDbParameter], withCompletion: (result: TheMovieDbResult<T>)->Void ) {
        self.api.request(self.commantRoute, parameters: parameters, withCompletion: withCompletion)
    }
}

public final class TheMovieDbListCommand : TheMovieDbCommand {
    
    internal var parameters: [TheMovieDbParameter]!
    public var page: UInt = 0
    public var total_results: UInt!
    public var total_pages: UInt!
    
    override public func buildDefaultParameters() -> [TheMovieDbParameter] {
        guard var parameters = self.parameters else { return super.buildDefaultParameters() }
        parameters = parameters.filter { $0.name != "page" }
        parameters.append(TheMovieDbParameter.page(value: self.page))
        return parameters
    }
    
    public func reload<T:TheMovieDbModelListProtocol>(withCompletion: (result: TheMovieDbResult<T>)->Void ) {
        self.gotoPage(self.page, withCompletion: withCompletion)
    }
    
    public func nextPage<T:TheMovieDbModelListProtocol>(withCompletion: (result: TheMovieDbResult<T>)->Void ) {
        self.gotoPage(self.page + 1, withCompletion: withCompletion)
    }
    
    public func previousPage<T:TheMovieDbModelListProtocol>(withCompletion: (result: TheMovieDbResult<T>)->Void ) {
        self.gotoPage(self.page - 1, withCompletion: withCompletion)
    }
    
    public func gotoPage<T:TheMovieDbModelListProtocol>(page: UInt, withCompletion: (result: TheMovieDbResult<T>)->Void ) {
        self.page = page
        self.execute(self.buildDefaultParameters(), withCompletion: withCompletion)
    }
    
    public override func execute<T:TheMovieDbModelListProtocol>(withCompletion: (result: TheMovieDbResult<T>)->Void ) {
        self.execute(self.buildDefaultParameters(), withCompletion: withCompletion)
    }
    
    public override func execute<T:TheMovieDbModelListProtocol>(parameters: [TheMovieDbParameter], withCompletion: (result: TheMovieDbResult<T>) -> Void) {
        //save parameters for next request
        self.parameters = parameters
        //execute
        super.execute(parameters, withCompletion: { (result:TheMovieDbResult<T>) in
            switch result {
            case .success(let model):
                self.page = model.page
                self.total_results = model.total_results
                self.total_pages = model.total_pages
            default: break
            }
            withCompletion(result: result)
        })
    }
}