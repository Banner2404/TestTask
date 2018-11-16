//
//  NetworkManager.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

protocol NetworkManager {
    func getWeather(latitude: Double, longitude: Double, completion: @escaping ResponseCompletion<OWMWeather, NetworkError>)
}

class DefaultNetworkManager: NetworkManager {
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping ResponseCompletion<OWMWeather, NetworkError>) {
        let request = URLRequest(method: .get,
                                 urlString: ApiUrls.weather,
                                 query: [URLQueryItem(name: "lat", value: String(latitude)),
                                         URLQueryItem(name: "lon", value: String(longitude)),
                                         URLQueryItem(name: "APPID", value: ApiKeys.openWeather),
                                         URLQueryItem(name: "units", value: "metric")])
        perform(request, responseType: OWMWeather.self, completion: completion)
    }
    
    private func perform<T: Decodable>(_ request: URLRequest, responseType: T.Type, completion: @escaping ResponseCompletion<T, NetworkError>) {
        print(request.url?.absoluteString)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.client(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                completion(.failure(.incorrectResponse))
                return
            }
            print(try? JSONSerialization.jsonObject(with: data, options: []))
            guard httpResponse.statusCode < 400 else {
                completion(.failure(.statusCode(httpResponse.statusCode)))
                return 
            }
            guard let responseObject = try? JSONDecoder().decode(responseType, from: data) else {
                completion(.failure(.unableToParse(data)))
                return 
            }
            completion(.success(responseObject))
        }.resume()
    }
}
