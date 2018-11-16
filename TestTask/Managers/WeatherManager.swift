//
//  WeatherManager.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

protocol WeatherManager {
    var latestWeather: Weather? { get }
}

extension Notification.Name {
    static let weatherManagerDidUpdateLatestWeather = Notification.Name("WeatherManagerDidUpdateLatestWeather")
}

class DefaultWeatherManager: WeatherManager {
    
    var latestWeather: Weather? {
        didSet {
            NotificationCenter.default.post(name: .weatherManagerDidUpdateLatestWeather, object: self)
        }
    }
    
    private let locationManager: LocationManager
    private let networkManager: NetworkManager
    
    init(locationManager: LocationManager, networkManager: NetworkManager) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateLocation), name: .locationManagerDidUpdateLatestLocation, object: nil)
    }
    
    @objc
    private func didUpdateLocation() {
        guard let location = locationManager.latestLocation else { return }
        networkManager.getWeather(latitude: location.clLocation.coordinate.latitude,
                                  longitude: location.clLocation.coordinate.longitude) { response in
                                    switch response {
                                    case .failure(let error):
                                        print(error)
                                    case .success(let owmWeather):
                                        self.latestWeather = Weather(location: location, temperature: owmWeather.temperature)
                                    }
        }
    }
}
