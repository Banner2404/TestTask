//
//  AppDelegate.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let locationManager = DefaultLocationManager()
        let networkManager = DefaultNetworkManager()
        let weatherManager = DefaultWeatherManager(locationManager: locationManager, networkManager: networkManager)
        locationManager.start()
        appCoordinator = AppCoordinator(window, locationManager: locationManager, weatherManager: weatherManager)
        appCoordinator.start()
        window.makeKeyAndVisible()
        return true
    }

}

