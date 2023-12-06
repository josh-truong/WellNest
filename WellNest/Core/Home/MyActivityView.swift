//
//  InactiveActivitiesView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import SwiftUI

struct MyActivityView: View {
    @StateObject var vm: ActivityViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if (!vm.activeActivities.isEmpty) {
                    Section(header: Text("Favorites").font(.title).padding()) {
                        ForEach(vm.activeActivities, id: \.id) { info in
                            ActivityCard(activity: info.activity, start: info.start, end: info.end, showProgress: false)
                                .onTapGesture {
                                    vm.moveToInctive(info)
                                }
                        }
                        .onMove { vm.move(from: $0, to: $1) }
                    }
                    .listRowSeparator(.hidden)
                }
                
                if (!vm.inactiveActivities.isEmpty) {
                    Section(header: Text("My exercises").font(.title).padding()) {
                        ForEach(vm.inactiveActivities, id: \.id) { info in
                            ActivityCard(activity: info.activity, start: info.start, end: info.end, showProgress: false)
                                .onTapGesture {
                                    vm.moveToActive(info)
                                }
                        }
                        .onDelete { vm.delete(from: $0) }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(PlainListStyle()) // Apply custom list style to remove default styling
            .navigationTitle("My Exercises")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: ExerciseView()) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem {
                    Button("", systemImage: "ellipsis", action: {  })
                }
            }
            .onAppear() {
                vm.getInactiveActivities()
            }
        }
    }
}
