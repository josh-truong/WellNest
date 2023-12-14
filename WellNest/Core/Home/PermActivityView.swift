//
//  PermActivityView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/13/23.
//

import SwiftUI
import CoreData

struct PermActivityView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest var water: FetchedResults<RecordEntity>
    @FetchRequest var weight: FetchedResults<RecordEntity>
    @FetchRequest var steps: FetchedResults<RecordEntity>
    
    @StateObject var vm: ActivityViewModel

    init(vm: ActivityViewModel) {
        _vm = StateObject(wrappedValue: vm)
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
            
            NavigationLink(destination: NutritionView()) {
                ActivityCard(Calories(), start: vm.todaysCalories, end: 1000, showProgress: false)
                    .onAppear { vm.getTodaysCalories(context: managedObjContext) }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
