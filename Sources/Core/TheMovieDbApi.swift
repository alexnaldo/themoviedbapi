//
//  TheMovieDb.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 02/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class TheMovieDbApi : TheMovieDbNetworkProtocol {
    
    public static let instance = TheMovieDbApi()
    
    public var commands: TheMovieDbCommands!
    private init() {
        self.commands = TheMovieDbCommands(api: self)
    }
    
    var options: TheMovieDbOptions!
    
    public static func configure(apiKey apiKey: String, baseUrl: String = "https://api.themoviedb.org/3")-> TheMovieDbApi {
        
        TheMovieDbApi.instance.options = TheMovieDbOptions(apiKey: apiKey, baseUrl: baseUrl)
        return TheMovieDbApi.instance
    }
    
    public static func configure(options options: TheMovieDbOptions)-> TheMovieDbApi {
        
        TheMovieDbApi.instance.options = options
        return TheMovieDbApi.instance
    }
    
    //MARK: TheMovieDbNetworkProtocol
    
    public var configuration: TheMovieDbConfigurationModel!

    func buildParameters( parameters: [TheMovieDbParameter] ) -> Dictionary<String, AnyObject> {
        
        var result = Dictionary<String, AnyObject>()
        for parameter in parameters {
            
            if let value = parameter.value {
                result[parameter.name] = value
            }
        }
        // every call must have api_key
        let apiKeyParameter = TheMovieDbParameter.api_key(value: self.options.apiKey)
        if result[apiKeyParameter.name] == nil {
            result[apiKeyParameter.name] = apiKeyParameter.value
        }
        return result
    }
    
    public func request<T where T: TheMovieDbModelProtocol>(command: TheMovieDbCommand, withCompletion: (result: TheMovieDbResult<T>)->Void) {
        let parameters = command.buildDefaultParameters()
        self.request(command.commantRoute, parameters: parameters, withCompletion: withCompletion)
    }
    
    //main network request method
    public func request<T where T: TheMovieDbModelProtocol>(commandRoute: String, parameters: [TheMovieDbParameter], withCompletion: (result: TheMovieDbResult<T>)->Void) {
        
        assert(self.options != nil, "API key not configured. Call first TheMovieDbApi.configure() method.")
        
        //assert configuration first call
        if commandRoute != "/configuration" && configuration == nil {
            self.commands.configuration().execute { (result: TheMovieDbResult<TheMovieDbConfigurationModel>) in
                if let error = result.error {
                    withCompletion(result: TheMovieDbResult.failure(error))
                } else {
                    // now, execute again
                    self.request(commandRoute, parameters: parameters, withCompletion: withCompletion)
                }
            }
        }
        else {
            
            //build correct request
            let parameters = self.buildParameters(parameters)
            //force ignore cache
            let request = {() -> Alamofire.Request in
                let mutableRequest = Alamofire.request(.GET, "\(self.options.baseUrl)\(commandRoute)", parameters: parameters)
                    .request as! NSMutableURLRequest
                
                mutableRequest.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
                return Alamofire.request(mutableRequest)
            }()
            //request now!!
            request.responseData { response in
                switch response.result {
                case .Success(let value) where response.response?.statusCode != 200:
                    let json = JSON(data: value)
                    let error = NSError(domain: self.options.baseUrl, code: json["status_code"].intValue, userInfo: [NSLocalizedDescriptionKey:json["status_message"].stringValue])
                    self.options.delegate?.logFailure(error)
                    withCompletion(result: TheMovieDbResult.failure(error))
                case .Success(let value) where response.response?.statusCode == 200:
                    let json = JSON(data: value)
                    let model = T(json: json)
                    
                    //model.command = TheMoviedb
                    
                    // every call to /configuration update itself
                    if commandRoute == "/configuration" {
                        self.configuration = model as! TheMovieDbConfigurationModel
                    }
                    withCompletion(result: TheMovieDbResult.success(model))
                case .Failure(let error):
                    self.options.delegate?.logConnectionFailure(error)
                    withCompletion(result: TheMovieDbResult.failure(error))
                default :
                    let error = NSError(domain: self.options.baseUrl, code: 404, userInfo: [NSLocalizedDescriptionKey:"Page not found"])
                    self.options.delegate?.logFailure(error)
                    withCompletion(result: TheMovieDbResult.failure(error))
                }
            }
        }
    }
}