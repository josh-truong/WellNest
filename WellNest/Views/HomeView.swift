//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import MapKit

// https://www.youtube.com/watch?v=gy6rp_pJmbo
struct HomeView: View {
    @ObservedObject var locationDataManager = LocationDataManager()
    @ObservedObject var viewModel: GeoConnectViewModel = GeoConnectViewModel()
    
    var body: some View {
//        switch locationDataManager.authorizationStatus {
//        case .authorizedWhenInUse:  // Location services are available.
//            if let currentCoord = locationDataManager.currentCoord {
//                GeoConnectView(origin: currentCoord)
//            }
//        case .restricted, .denied:  // Location services currently unavailable.
//            Text("Current location data was restricted or denied.")
//        case .notDetermined:        // Authorization not determined yet.
//            Text("Finding your location...")
//            ProgressView()
//        default:
//            ProgressView()
//        }
        GeoConnectView(vm: viewModel)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
