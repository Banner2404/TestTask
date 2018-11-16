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
    var latestLocation: Location? { get }
    
    func requestAuthorizationIfNeeded()
    func start()
}

extension Notification.Name {
    static let locationManagerDidUpdateLatestLocation = Notification.Name("LocationManagerDidUpdateLatestLocation")
}

class DefaultLocationManager: NSObject, LocationManager {
    
    var latestLocation: Location? {
        didSet {
            NotificationCenter.default.post(name: .locationManagerDidUpdateLatestLocation, object: self)
        }
    }
    private let geocoder = CLGeocoder()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
    }
    
    func requestAuthorizationIfNeeded() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func start() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    private func loadCityInfo(for clLocation: CLLocation) {
        if geocoder.isGeocoding {
            geocoder.cancelGeocode()
        }
        geocoder.reverseGeocodeLocation(clLocation) { (placemarks, error) in
            if let error = error {
                print(error)
            }
            guard let cityName = placemarks?.first?.locality else { return }
            print(cityName)
            self.latestLocation = Location(clLocation: clLocation, city: cityName)
        }
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
        guard let location = locations.last else { return }
        print(locations)
        loadCityInfo(for: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
