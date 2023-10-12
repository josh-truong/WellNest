//
//  LocationService.swift
//  WellNest
//
//  Created by Joshua Truong on 10/10/23.
//

import Foundation
import MapKit

class LocationService {
    static func searchLocations(_ searchText: String, region: MKCoordinateRegion) async -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        
        let results = try? await MKLocalSearch(request: request).start()
        return results?.mapItems ?? []
    }
    
    static func fetchRoute(from origin: MKMapItem, to destination: MKMapItem) async -> MKRoute? {
        let request = MKDirections.Request()
        request.source = origin
        request.destination = destination

        let result = try? await MKDirections(request: request).calculate()
        return result?.routes.first
    }
}
