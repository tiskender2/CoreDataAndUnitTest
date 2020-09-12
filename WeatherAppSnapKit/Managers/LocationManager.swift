//
//  LocationManager.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
protocol LocationManagerDelegates: class {
    func recievedLocation()
}
class LocationManager: NSObject {
    let locationManager = CLLocationManager()
    static let shared = LocationManager()
    weak var delegate:LocationManagerDelegates?
    override init() {
        super.init()
        checkLocationPerm()
    }
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    func checkLocationPerm(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                getUserLocation()
            case .authorizedAlways, .authorizedWhenInUse:
                getUserLocation()
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            HomeVM.shared.lat = "\(location.coordinate.latitude)"
            HomeVM.shared.lon = "\(location.coordinate.longitude)"
            locationManager.stopUpdatingLocation()
            delegate?.recievedLocation()
        }
    }
}
