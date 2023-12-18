//
//  MusicView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import FirebaseAuth

struct FriendsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var firebase: FirebaseManager
    @State private var showAdd: Bool = false
    @State private var friendEmail: String = ""
    @State private var showRequest: Bool = false
    
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
                    ForEach(firebase.activities.sorted(by: { $0.key < $1.key }), id: \.key) { friend, activities in
                        DisclosureGroup(friend, isExpanded: .constant(true)) {
                            ForEach(activities, id: \.id) { activity in
                                FriendActivityCard(name: activity.name, image: activity.image, start: activity.start, end: activity.end, unit: activity.name)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 16))
                    }
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
                await firebase.fetchActivities()
            }
            .toolbar {
                ToolbarItem {
                    Button("\(firebase.currentUser.requests.count)", systemImage: "person.badge.plus", action: { showAdd.toggle() })
                }
                ToolbarItem {
                    Button("", systemImage: "bell", action: { showRequest.toggle() })
                        .foregroundStyle(Color.blue)
                        .disabled(firebase.currentUser.requests.isEmpty)
                }
            }
            .sheet(isPresented: $showRequest) {
                ScrollView {
                    VStack {
                        ForEach(firebase.requests, id: \.id) { request in
                            HStack {
                                Text(request.fullname)
                                Spacer()
                                Button(action: {
                                    Task {
                                        await firebase.acceptRequest(fid: request.id)
                                    }
                                    showRequest.toggle()
                                }) {
                                    Label("", systemImage: "checkmark")
                                }
                                Button(action: {
                                    Task {
                                        await firebase.declineRequest(fid: request.id)
                                    }
                                    showRequest.toggle()
                                }) {
                                    Label("", systemImage: "xmark")
                                }
                            }
                            .padding()
                        }
                    }
                }
                .onAppear() {
                    Task {
                        await firebase.getUserRequests()
                    }
                }
            }
        }
    }
}

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
