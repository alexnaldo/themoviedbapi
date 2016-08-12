//
//  TheMovieDbAndOrQuery.swift
//  TheMovieDbApi
//
//  Created by Alexnaldo Santos on 06/08/16.
//  Copyright © 2016 Alexnaldo Santos. All rights reserved.
//

import Foundation


/* Expected value is an integer (the id). Comma separated indicates an 'AND' query, while a pipe (|) separated value indicates an 'OR'. */
public final class TheMovieDbDiscoverQuery: CustomStringConvertible {
    
    private let type: String
    private let id: Int
    
    private var parent: TheMovieDbDiscoverQuery!
    private var next: TheMovieDbDiscoverQuery!
    
    private init(type:String, id:Int) {
        
        self.type = type
        self.id = id
    }
    
    private convenience init(type:String, id:Int, next: TheMovieDbDiscoverQuery) {
        self.init(type:type, id:id)
        
        self.next = next
    }
    
    public static func and(id: Int)->TheMovieDbDiscoverQuery {
        return TheMovieDbDiscoverQuery(type:";", id: id)
    }
    
    public func and(id: Int)->TheMovieDbDiscoverQuery {
        self.next = TheMovieDbDiscoverQuery.and(id)
        self.next!.parent = self
        return self.next!
    }
    
    public static func or(id: Int)->TheMovieDbDiscoverQuery {
        return TheMovieDbDiscoverQuery(type:"|", id: id)
    }
    
    public func or(id: Int)->TheMovieDbDiscoverQuery {
        self.next = TheMovieDbDiscoverQuery.or(id)
        self.next!.parent = self
        return self.next!
    }
    
    private func query()-> String {
        
        var queryDescription = "\(self.type)\(self.id)"
        
        if self.parent == nil {
            queryDescription = "\(self.id)"
        }
        
        var nextQuery = self.next
        while let next = nextQuery {
            queryDescription = "\(queryDescription)\(next.query())"
            nextQuery = next.next
        }
        return queryDescription
    }
    
    public var description: String {
        
        /* 
            using this behavior makes possible extract complete query for any query item
         
            let a = TheMovieDbDiscoverQuery.and(1)
            let b = a.and(2)
         
            a.description == b.description
         
         */
        
        var firstQuery = self
        while let parent = firstQuery.parent {
            firstQuery = parent
        }
        
        return firstQuery.query()
    }
}