//
//  URLRequest.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(method: Method, urlString: String, query: [URLQueryItem]) {
        var components = URLComponents(string: urlString)
        components?.queryItems = query
        self.init(url: (components?.url)!)
        self.httpMethod = method.rawValue
    }
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        
    }
}
