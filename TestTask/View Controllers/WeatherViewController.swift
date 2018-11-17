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
    @IBOutlet private weak var weatherLabel: UILabel!
    
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
        guard let weather = weatherManager.latestWeather else {
            weatherLabel.text = "No data"
            return
        }
        weatherLabel.text = "\(Int(weather.temperature)) degrees in \(weather.location.city)"
    }
}
