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
    @FetchRequest var water: FetchedResults<RecordEntity>
    @FetchRequest var weight: FetchedResults<RecordEntity>
    @FetchRequest var steps: FetchedResults<RecordEntity>
    
    @StateObject var vm = ActivityViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        let fetchRequest: NSFetchRequest<RecordEntity> = RecordEntity.fetchRequest()
        
        var predicate = NSPredicate(
            format: "name CONTAINS[cd] %@ AND timestamp >= %@ AND timestamp <= %@",
            Weight().name,
            Date().startOfDay as NSDate,
            Date().endOfDay as NSDate
        )
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \RecordEntity.timestamp, ascending: false) ]
        fetchRequest.fetchLimit = 1
        _weight = FetchRequest(fetchRequest: fetchRequest)
        
        predicate = NSPredicate(
            format: "name CONTAINS[cd] %@ AND timestamp >= %@ AND timestamp <= %@",
            Water().name,
            Date().startOfDay as NSDate,
            Date().endOfDay as NSDate
        )
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \RecordEntity.timestamp, ascending: false) ]
        fetchRequest.fetchLimit = 0
        _water = FetchRequest(fetchRequest: fetchRequest)
        
        predicate = NSPredicate(
            format: "name CONTAINS[cd] %@ AND timestamp >= %@ AND timestamp <= %@",
            Steps().name,
            Date().startOfDay as NSDate,
            Date().endOfDay as NSDate
        )
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \RecordEntity.timestamp, ascending: false) ]
        fetchRequest.fetchLimit = 0
        _steps = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: GeoConnectView().navigationBarTitleDisplayMode(.inline)) {
                ActivityCard(Steps(), start: Int(steps.first?.quantity ?? 0), end: 200, showProgress: false)
            }
            .buttonStyle(PlainButtonStyle())
            
            HStack {
                NavigationLink(destination: EditActivityView(activity: Weight())) {
                    ActivityCard(Weight(), start: Int(weight.first?.quantity ?? 0), end: 200, showProgress: false, disableName: true)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: EditActivityView(activity: Water())) {
                    ActivityCard(Water(), start: water.reduce(0) { (result, record) in return result + Int(record.quantity) }, end: 8, showProgress: false, disableName: true)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            ActivityCard(Calories(), start: vm.todaysCalories, end: 1000, showProgress: false)
                .onAppear { vm.getTodaysCalories(context: managedObjContext) }
            
            LazyVGrid(columns: columns) {
                ForEach(activities) { info in
                    NavigationLink(destination: ChronoView(entity: info)) {
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
