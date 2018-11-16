//
//  LocationManager.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManager {
    var latestLocation: CLLocation? { get }
    
    func requestAuthorizationIfNeeded()
}

extension Notification.Name {
    static let LocationManagerDidUpdateLatestLocation = Notification.Name("LocationManagerDidUpdateLatestLocation")
}

class DefaultLocationManager: NSObject, LocationManager {
    
    var latestLocation: CLLocation? {
        didSet {
            NotificationCenter.default.post(name: .LocationManagerDidUpdateLatestLocation, object: self)
        }
    }
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
    }
    
    func requestAuthorizationIfNeeded() {
        locationManager.requestWhenInUseAuthorization()
    }
}

//MARK: - CLLocationManagerDelegate
extension DefaultLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status.rawValue)
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latestLocation = locations.first
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
