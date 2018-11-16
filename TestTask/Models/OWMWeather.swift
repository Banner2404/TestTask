//
//  Weather.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

struct OWMWeather: Decodable {
    let temperature: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let main = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        temperature = try main.decode(Double.self, forKey: .temp)
    }
    
    enum CodingKeys: String, CodingKey {
        case main
    }
    
    enum MainCodingKeys: String, CodingKey {
        case temp
    }
}
