//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import SwiftData

// https://www.youtube.com/watch?v=gy6rp_pJmbo
struct HomeView: View {
    @Environment(\.modelContext) var context
    
    @State private var path = [TaskModel]()
    @State private var sortOrder = SortDescriptor(\TaskModel.title)
    var body: some View {
        NavigationStack(path: $path) {
            TasksView(sort: sortOrder)
            .navigationTitle("Todos")
            .navigationDestination(for: TaskModel.self, destination: EditTaskView.init)
            .toolbar {
                ToolbarItem {
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                }
                
                ToolbarItem {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\TaskModel.title))
                            Text("Priority")
                                .tag(SortDescriptor(\TaskModel.priority, order: .reverse))
                            
                            Text("Date")
                                .tag(SortDescriptor(\TaskModel.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
            }
        }
    }
}

extension HomeView {
    func addDestination() {
        let destination = TaskModel()
        context.insert(destination)
        path = [destination]
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}