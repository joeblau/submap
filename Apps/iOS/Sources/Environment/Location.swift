//
//  Location.swift
//  Submap
//
//  Created by Joe Blau on 11/9/23.
//

import SwiftUI
import CoreLocation

@Observable class Location: NSObject {
    
    static var SETTING_LOCATION = "setting-location"
    var isOn: Bool = UserDefaults.standard.bool(forKey: Location.SETTING_LOCATION) {
        didSet {
            UserDefaults.standard.setValue(isOn, forKey: Location.SETTING_LOCATION)
        }
    }
    
    let manager: CLLocationManager = .init()
    let goecoder: CLGeocoder = .init()
    
    var currentLocation: CLLocation = .init()
    var placemark: CLPlacemark? = nil
    
    override init() {
        super.init()
        manager.delegate = self
        manager.distanceFilter = 100
    }
    
    func requestAccess() {
        manager.requestAlwaysAuthorization()
    }
    
    func start() {
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
    }
}

extension Location: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: start()
        case .denied, .notDetermined, .restricted: stop()
        @unknown default: stop()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last ?? .init()
        goecoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
            guard let placemark = placemarks?.last else { return }
            self.placemark = placemark
        }
    }
}

struct LocationKey: EnvironmentKey {
    static let defaultValue: Location = .init()
}

extension EnvironmentValues {
    var location: Location {
        get { self[LocationKey.self] }
        set { self[LocationKey.self] = newValue }
    }
}
