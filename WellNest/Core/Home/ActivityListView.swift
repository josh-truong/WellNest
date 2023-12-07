//
//  ActivityList.swift
//  WellNest
//
//  Created by Joshua Truong on 11/28/23.
//

import SwiftUI
import SwiftData
import CoreData

struct ActivityListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "active == true")) var activities: FetchedResults<ActivityEntity>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)]) var food: FetchedResults<FoodEntity>
    
    @StateObject var vm = ActivityViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            ActivityCard(Weight(), start: 360, end: 200, showProgress: false)
            ActivityCard(Calories(), start: vm.todaysCalories, end: 1000, showProgress: false)
                .onAppear { vm.getTodaysCalories(context: managedObjContext) }
            ActivityCard(Water(), start: 0, end: 8, showProgress: false)
            
            LazyVGrid(columns: columns) {
                ForEach(activities) { info in
                    NavigationLink(destination: TimerView(entity: info)) {
                        ActivityCard(info)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 1)
                
                NavigationLink(destination: MyActivityView(vm: vm)) {
                    ActivityButton()
                        .aspectRatio(1.0, contentMode: .fit)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear() {
            vm.preload(context: managedObjContext)
        }
    }
}
