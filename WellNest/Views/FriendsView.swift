//
//  MusicView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct FriendsView: View {
//    var db: FirebaseManager = FirebaseManager()
//    @ObservedObject var locationDataManager = LocationDataManager()
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var firebase: FirebaseManager
    @State var count = 0
    var body: some View {
        NavigationStack {
            List {
                DisclosureGroup("Friend name", isExpanded: .constant(true)) {
                    ForEach(firebase.activities, id: \.id) { activity in
                        FriendActivityCard(name: activity.name, image: activity.image, start: activity.start, end: activity.end, unit: activity.name)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 16))
            }
            .padding()
            .listStyle(.plain)
            .onAppear {
                if let user = auth.currentUser {
                    firebase.startListening(user: user)
                    Task {
                        await firebase.fetchActivities(user: user)
                    }
                }
            }
            .onDisappear {
                firebase.stopListening()
            }
            .toolbar {
                ToolbarItem {
                    Button("", systemImage: "plus", action: {
                        if let user = auth.currentUser {
                            Task {
                                await firebase.sendRequest(email: "joshktruong@gmail.com", user: user, completion: { status in
                                    if (status) {
                                        print("Request sent")
                                    } else {
                                        print("Request not sent")
                                    }
                                })
                            }
//                                await firebase.acceptRequest(id: user.requests.first ?? "", user: user)
//                                await firebase.addActivity(user: user, activity: FriendActivity(name: "Activity \(count)", image: "figure.walk", start: 10, end: 100, unit: "minutes"))
//                                count+=1
                        }
                    })
                }
                
                ToolbarItem {
                    Button("", systemImage: "circle", action: {
                        if let user = auth.currentUser {
                            Task {
                                await firebase.acceptRequest(id: user.requests.first ?? "", user: user)
                            }
                        }
                    })
                }
            }
            
//            ScrollView {
//                switch locationDataManager.authorizationStatus {
//                    case .authorizedWhenInUse:  // Location services are available.
//            //            if let currentCoord = locationDataManager.currentCoord {
//            //                GeoConnectView(vm: viewModel)
//            //            }
//                        
//                    case .restricted, .denied:  // Location services currently unavailable.
//                        //Text("Current location data was restricted or denied.")
//                        NoLocationView()
//                    case .notDetermined:        // Authorization not determined yet.
//                        Text("Finding your location...")
//                        ProgressView()
//                    default:
//                        ProgressView()
//                }
//            }
//            .toolbarNavBar("Friends")
        }
    }
}
