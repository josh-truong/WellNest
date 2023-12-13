//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import SwiftData


struct HomeView: View {
    @Environment(\.modelContext) var context
    
    @State private var path = [TaskModel]()
    @State private var sortOrder = SortDescriptor(\TaskModel.title)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ActivityListView()
            }
            .navigationTitle("Activity List")
            .profile()
            .padding()
        }

//        NavigationStack(path: $path) {
//            VStack(alignment: .leading) {
//                
////                TasksView(sort: sortOrder)
////                .onChange(of: path) { oldValue, newValue in
////                    if (newValue.isEmpty) {
////                        let title = oldValue.first?.title ?? ""
////                        if (title.isEmpty) {
////                            context.delete(oldValue.first!)
////                        }
////                    }
////                }
//            }
//            .navigationTitle("WellNest")
//            .navigationDestination(for: TaskModel.self, destination: EditTaskView.init)
//            .toolbar {
//                ToolbarItem {
//                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
//                        Picker("Sort", selection: $sortOrder) {
//                            Text("Name")
//                                .tag(SortDescriptor(\TaskModel.title))
//                            Text("Priority")
//                                .tag(SortDescriptor(\TaskModel.priority, order: .reverse))
//                            
//                            Text("Date")
//                                .tag(SortDescriptor(\TaskModel.date))
//                        }
//                        .pickerStyle(.inline)
//                    }
//                }
//                
//                ToolbarItem {
//                    Button("Add Destination", systemImage: "plus", action: addDestination)
//                }
//            }
//            .padding()
//        }
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


struct ActivityDetailView: View {
    let info: ActivityInfo

    var body: some View {
        Text("Detail View for \(info.activity.name)")
            .padding()
            .navigationTitle(info.activity.name)
    }
}
