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
    
    @State var entity: FetchRequest<RecordEntity>?
    @State var value: Float = 0
    @State var showWater: Bool = false
    @State var showWeight: Bool = false
    
    @State var stepGoal: Int = 0
    @State var weightGoal: Int = 0
    @State var waterGoal: Int = 0
    
    var body: some View {
        VStack {
            NavigationLink(destination: GeoConnectView().navigationBarTitleDisplayMode(.inline)) {
                ActivityCard(Steps(), start: Int(steps.first?.quantity ?? 0), end: stepGoal, showProgress: false)
                    .onDisappear() { getGoals() }
            }
            .buttonStyle(PlainButtonStyle())
            
            HStack {
                ActivityCard(Weight(), start: Int(weight.first?.quantity ?? 0), end: weightGoal, showProgress: false, disableName: true)
                    .onTapGesture { showWeight.toggle() }
                    .sheet(isPresented: $showWeight, content: {
                        RecordEntitySlider(activity: Weight(), min: 0, max: 300)
                            .presentationDetents([.height(200)])
                            .presentationCornerRadius(12)
                            .onDisappear() { getGoals() }
                    })
                
                ActivityCard(Water(), start: water.reduce(0) { (result, record) in return result + Int(record.quantity) }, end: waterGoal, showProgress: false, disableName: true)
                    .onTapGesture { showWater.toggle() }
                    .sheet(isPresented: $showWater, content: {
                        RecordEntitySlider(activity: Water(), min: 0, max: 10)
                            .presentationDetents([.height(200)])
                            .presentationCornerRadius(12)
                            .onDisappear() { getGoals() }
                    })
            }
            
            NavigationLink(destination: NutritionView()) {
                ActivityCard(Calories(), start: vm.todaysCalories, end: Int(vm.calories), showProgress: false)
                    .onAppear {
                        vm.getTodaysCalories(context: managedObjContext)
                        vm.getTotalCalories()
                    }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear() { getGoals() }
    }
    
    func getGoals() {
        stepGoal = getGoal(Steps())
        weightGoal = getGoal(Weight())
        waterGoal = getGoal(Water())
    }
    
    func getGoal(_ activity: Activity) -> Int {
        if UserDefaults.standard.object(forKey: activity.name) == nil {
            setGoal(activity, value: activity.goal)
        }
        return UserDefaults.standard.integer(forKey: activity.name)
    }

    func setGoal(_ activity: Activity, value: Int) {
        UserDefaults.standard.set(value, forKey: activity.name)
    }
}
