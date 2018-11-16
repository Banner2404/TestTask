//
//  WeatherCoordinator.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

class WeatherCoordinator {
    
    private let window: UIWindow
    private let weatherManager: WeatherManager
    
    init(_ window: UIWindow, weatherManager: WeatherManager) {
        self.window = window
        self.weatherManager = weatherManager
    }
    
    func start() {
        
        window.rootViewController = LoadingViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.window.rootViewController = WeatherViewController(weatherManager: self.weatherManager)
        }
    }
}
