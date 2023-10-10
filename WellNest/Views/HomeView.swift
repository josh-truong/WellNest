//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    switch locationDataManager.authorizationStatus {
                    case .authorizedWhenInUse:  // Location services are available.
                        Text("Your current location is:")
                        Text("Latitude: \(locationDataManager.coordinate?.latitude.description ?? "Error loading")")
                        Text("Longitude: \(locationDataManager.coordinate?.longitude.description ?? "Error loading")")
                        
                    case .restricted, .denied:  // Location services currently unavailable.
                        Text("Current location data was restricted or denied.")
                    case .notDetermined:        // Authorization not determined yet.
                        Text("Finding your location...")
                        ProgressView()
                    default:
                        ProgressView()
                    }
                }
            }
            .toolbarNavBar("Home")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
