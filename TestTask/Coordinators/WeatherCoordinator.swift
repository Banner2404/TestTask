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
    private var state = State.unknown
    
    init(_ window: UIWindow, weatherManager: WeatherManager) {
        self.window = window
        self.weatherManager = weatherManager
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateWeather), name: .weatherManagerDidUpdateLatestWeather, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        updateToDesiredState()
    }
    
    @objc
    private func didUpdateWeather() {
        updateToDesiredState()
    }
    
    private func updateToDesiredState() {
        set(desiredState())
    }
    
    private func desiredState() -> State {
        return weatherManager.latestWeather == nil ? .loading : .loaded
    }
    
    private func set(_ newState: State) {
        guard newState != state else { return }
        switch newState {
        case .loading:
            window.rootViewController = LoadingViewController()
        case .loaded:
            window.rootViewController = WeatherViewController(weatherManager: weatherManager)
        case .unknown:
            break
        }
    }
    
    private enum State {
        case unknown
        case loading
        case loaded
    }
}
