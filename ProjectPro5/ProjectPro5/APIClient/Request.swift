//
//  Request.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import Foundation

final class Request{
    
    private struct Constants {
        static let baseURL = "https://restcountries.com/v3.1"
    }
    
    private let endpont: Endpoint
    
    private let pathComponent: String
    
    private var urlString: String{
        var string = Constants.baseURL
        string += "/"
        string += endpont.rawValue
        
        if !pathComponent.isEmpty{
            string += "/\(pathComponent)"
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endpont: Endpoint, pathComponent: String = "") {
        self.endpont = endpont
        self.pathComponent = pathComponent
    }
}

extension Request{
    static let listCountryRequest = Request(endpont: .all)
}
