//
//  InactiveActivitiesView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import SwiftUI

struct MyActivityView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "active == true")) var active: FetchedResults<ActivityEntity>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "active == false")) var inactive: FetchedResults<ActivityEntity>
    @StateObject var vm: ActivityViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if (!active.isEmpty) {
                    Section(header: Text("Favorites").font(.title).padding()) {
                        ForEach(active, id: \.id) { info in
                            ActivityCard(info, showProgress: false)
                                .onTapGesture { info.toggle(context: managedObjContext) }
                        }
                        .onMove { fromOffsets, toOffset in
                            print("\(fromOffsets) \(toOffset)")
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                
                if !inactive.isEmpty {
                    Section(header: Text("My exercises").font(.title).padding()) {
                        ForEach(inactive, id: \.id) { info in
                            ActivityCard(info, showProgress: false)
                                .onTapGesture { info.toggle(context: managedObjContext) }
                        }
                        .onDelete { $0.forEach { inactive[$0].delete(context: managedObjContext) }}
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(PlainListStyle())
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
        }
    }
}
