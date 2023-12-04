//
//  GeoConnectViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 10/10/23.
//

import Foundation
import MapKit

class GeoConnectViewModel : ObservableObject {
    @Published var publishedResults = [MKMapItem]()
    @Published var publishedRoute: MKRoute?
    
    let locationService = LocationService.shared
    
    @MainActor
    func searchLocation(_ searchText: String) async {
        publishedResults = await locationService.searchLocations(searchText, region: .userRegion)
    }
    
    @MainActor
    func fetchRoute(from origin: MKMapItem, to destination: MKMapItem) async {
        publishedRoute = await locationService.fetchRoute(from: origin, to: destination)
    }
}
