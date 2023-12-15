//
//  MusicView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import FirebaseAuth

struct FriendsView: View {
    @EnvironmentObject var firebase: FirebaseManager
    @State private var showAdd: Bool = false
    @State private var friendEmail: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if showAdd {
                    HStack {
                        TextField("Search by email", text: $friendEmail)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        Spacer()
                        Button("", systemImage: "arrow.right", action: {
                            Task {
                                await firebase.sendRequest(email: friendEmail)
                            }
                            showAdd.toggle()
                        })
                    }
                    .padding()
                }
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
            }
            .onAppear {
                firebase.startListening()
            }
            .onDisappear {
                firebase.stopListening()
            }
            .task {
//                await firebase.fetchActivities()
            }
            .toolbar {
                ToolbarItem {
                    Button("\(firebase.currentUser.requests.count)", systemImage: "person.badge.plus", action: { showAdd.toggle() })
                }
                ToolbarItem {
                    Button {
                        Task {
                            if let id = firebase.currentUser.requests.first {
                                await firebase.acceptRequest(id: id)
                            }
                        }
                        print(firebase.currentUser.requests)
                    } label: {
                        Image(systemName: "bell")
                    }
                    .foregroundStyle(firebase.currentUser.requests.isEmpty ? Color.blue : Color.green)
                }
            }
        }
    }
}

//await firebase.addActivity(user: user, activity: FriendActivity(name: "Activity \(count)", image: "figure.walk", start: 10, end: 100, unit: "minutes"))

//switch locationDataManager.authorizationStatus {
//    case .authorizedWhenInUse:  // Location services are available.
////            if let currentCoord = locationDataManager.currentCoord {
////                GeoConnectView(vm: viewModel)
////            }
//
//    case .restricted, .denied:  // Location services currently unavailable.
//        //Text("Current location data was restricted or denied.")
//        NoLocationView()
//    case .notDetermined:        // Authorization not determined yet.
//        Text("Finding your location...")
//        ProgressView()
//    default:
//        ProgressView()
//}
