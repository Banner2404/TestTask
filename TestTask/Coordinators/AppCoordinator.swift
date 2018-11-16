//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private var tutorialCoordinator: TutorialCoordinator?
    private var weatherCoordinator: WeatherCoordinator?

    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        startTutorialFlow()
    }
    
    private func startTutorialFlow() {
        let coordinator = TutorialCoordinator(window)
        coordinator.delegate = self
        coordinator.start()
        tutorialCoordinator = coordinator
    }
    
    private func startWeatherFlow() {
        let coordinator = WeatherCoordinator(window)
        //coordinator.delegate = self
        coordinator.start()
        weatherCoordinator = coordinator
    }
}

//MARK: - TutorialCoordinatorDelegate
extension AppCoordinator: TutorialCoordinatorDelegate {
    
    func tutorialCoordinatorDidComplete(_ coordinator: TutorialCoordinator) {
        tutorialCoordinator = nil
        startWeatherFlow()
    }
}
