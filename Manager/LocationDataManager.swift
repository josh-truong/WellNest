//
//  LocationDataManager.swift
//  WellNest
//
//  Created by Joshua Truong on 10/9/23.
//

import Foundation
import CoreLocation

// Reference
// https://coledennis.medium.com/tutorial-connecting-core-location-to-a-swiftui-app-dc62563bd1de
// https://www.youtube.com/watch?v=4IlNA4xNM3k
class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var coordinate: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
    }
    
    func requestLocationUpdate() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            authorizationStatus = .authorizedWhenInUse
            requestLocationUpdate()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
            authorizationStatus = .restricted
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Latitude: \(location.coordinate.latitude)")
            print("Longitude: \(location.coordinate.longitude)")
            coordinate = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

