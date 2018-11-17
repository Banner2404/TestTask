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
    var authorizationStatus: CLAuthorizationStatus? { get }
    
    func requestAuthorizationIfNeeded()
    func start()
}

extension Notification.Name {
    static let locationManagerDidUpdateLatestLocation = Notification.Name("LocationManagerDidUpdateLatestLocation")
    static let locationManagerDidUpdateAuthorization = Notification.Name("LocationManagerDidUpdateAuthorization")
}

class DefaultLocationManager: NSObject, LocationManager {
    
    var latestLocation: Location? {
        didSet {
            NotificationCenter.default.post(name: .locationManagerDidUpdateLatestLocation, object: self)
        }
    }
    var authorizationStatus: CLAuthorizationStatus? {
        didSet {
            NotificationCenter.default.post(name: .locationManagerDidUpdateAuthorization, object: self)
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
            guard let placemark = placemarks?.first else { return }
            guard let cityName = placemark.locality ?? placemark.name else { return }
            self.latestLocation = Location(clLocation: clLocation, city: cityName)
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension DefaultLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
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
