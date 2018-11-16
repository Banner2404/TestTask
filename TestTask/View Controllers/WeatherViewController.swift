//
//  WeatherViewController.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

class WeatherViewController: BaseViewController {

    private let weatherManager: WeatherManager
    
    init(weatherManager: WeatherManager) {
        self.weatherManager = weatherManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeatherInfo), name: .weatherManagerDidUpdateLatestWeather, object: nil)
        updateWeatherInfo()
    }
    
    @objc
    private func updateWeatherInfo() {
        print(weatherManager.latestWeather)
    }
}
