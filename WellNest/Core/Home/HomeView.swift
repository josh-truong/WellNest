//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "active == true")) var items: FetchedResults<ActivityEntity>
    @EnvironmentObject var chrono: ChronoViewModel
    @StateObject var vm = ActivityViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PermActivityView(vm: vm)
                
                if !chrono.isRunning {
                    ActivityListView(vm: vm)
                } else {
                    TimerCard()
                }
            }
            .navigationTitle("Activity List")
            .profile()
            .padding()
        }
        .onAppear() {
            let activities = items.map { item in
                let start = (item.records ?? []).reduce(0) { result, record in
                    guard let record = record as? ActivityInfoEntity else { return result }
                    return result + Int(record.elapsedSeconds)
                }
                return FriendActivity(name: item.name ?? "", image: item.image ?? "", start: start, end: Int(item.goal), unit: item.unit ?? "")
            }
            
            Task {
                await FirebaseManager().addActivities(activities)
            }
        }
    }
}
