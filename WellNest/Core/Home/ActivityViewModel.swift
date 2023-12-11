//
//  ActivityViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation
import CoreData

@MainActor
class ActivityViewModel : ObservableObject {
    @Published var todaysCalories: Int = 0
    
    func getTodaysCalories(context: NSManagedObjectContext) {
        let request: NSFetchRequest<FoodEntity> = FoodEntity.fetchRequest()
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)

        let datePredicate = NSPredicate(format: "(timestamp >= %@) AND (timestamp < %@)", startDate as CVarArg, endDate! as CVarArg)
        request.predicate = datePredicate
        do {
            let total = try context.fetch(request).reduce(0) { $0 + Int($1.energy) }
            self.todaysCalories = total
        } catch {
            print("Could not get total calories. \(error.localizedDescription)")
        }
    }

    func preload(context: NSManagedObjectContext) {
        let preloadActiveActivities: [ActivityInfo] = [
            ActivityInfo(activity: Running(), goal: 10000),
            ActivityInfo(activity: Cycling(), goal: 300),
            ActivityInfo(activity: WeightLifting(), goal: 1000),
        ]
        
        let preloadInactiveActivities: [ActivityInfo] = [
            ActivityInfo(activity: Soccer(), goal: 300),
            ActivityInfo(activity: Basketball(), goal: 300),
            ActivityInfo(activity: StairStepper(), goal: 300),
            ActivityInfo(activity: Hiking(), goal: 300)
        ]
        
        if (UserDefaultService().getExecutedPreload()) {
            do {
                let existingEntities = try fetchAllEntities(context: context)
                if existingEntities.isEmpty {
                    print("Preloading activities")

                    preloadActiveActivities.forEach { item in
                        createActivityEntity(from: item, active: true, context: context)
                    }
                    
                    preloadInactiveActivities.forEach { item in
                        createActivityEntity(from: item, active: false, context: context)
                    }
                }
                UserDefaultService().setExecutedPreload(false)
            } catch {
                print("Error fetching entities: \(error)")
            }
        }
    }
    
    func fetchAllEntities(context: NSManagedObjectContext) throws -> [ActivityEntity] {
        let fetchRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        return try context.fetch(fetchRequest)
    }
    
    func createActivityEntity(from activityInfo: ActivityInfo, active: Bool, context: NSManagedObjectContext) {
        let activity = activityInfo.activity
        ActivityEntity().add(activity, active: active, context: context)
    }
}
