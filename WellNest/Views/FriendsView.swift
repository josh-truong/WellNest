//
//  MusicView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct FriendsView: View {
    var db: FirebaseManager = FirebaseManager()
    @ObservedObject var locationDataManager = LocationDataManager()
    @ObservedObject var viewModel: GeoConnectViewModel = GeoConnectViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                switch locationDataManager.authorizationStatus {
                    case .authorizedWhenInUse:  // Location services are available.
            //            if let currentCoord = locationDataManager.currentCoord {
            //                GeoConnectView(vm: viewModel)
            //            }
                        GeoConnectView(vm: viewModel)
                    case .restricted, .denied:  // Location services currently unavailable.
                        //Text("Current location data was restricted or denied.")
                        NoLocationView()
                    case .notDetermined:        // Authorization not determined yet.
                        Text("Finding your location...")
                        ProgressView()
                    default:
                        ProgressView()
                }
            }
            .toolbarNavBar("Friends")
        }
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
