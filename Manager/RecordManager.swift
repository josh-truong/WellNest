//
//  RecordManager.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation
import CoreData


//@objc(ActivityGroupRecord)
//public class ActivityGroupRecord : NSManagedObject {
//    @NSManaged public var activityID: Int
//    @NSManaged public var name: String
//    @NSManaged public var unit: String
//    
//    @NSManaged public var records: NSSet?
//}
//
//@objc(ActivityRecord)
//public class ActivityRecord : NSManagedObject {
//    @NSManaged public var timestamp: Date
//    @NSManaged public var start: Int
//    @NSManaged public var end: Int
//}

class RecordManager: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "FoodModel")
        self.container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func saveFood(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("uh oh")
        }
    }
    
    func addFood(item: WgerIngredientResult, context: NSManagedObjectContext) {
        let food = FoodEntity(context: context)
        food.timestamp = Date()
        food.id = Int64(item.id)
        food.uuid = item.uuid
        food.code = item.code
        food.name = item.name
        food.energy = Int64(item.energy)
        food.protein = Int16(Int(item.protein) ?? 0)
        food.carbohydrates = Float(item.carbohydrates) ?? 0
        food.sugarCarbContent = Float(item.carbohydratesSugar ?? "") ?? 0
        food.fat = Float(item.fat) ?? 0
        food.saturatedFatContent = Float(item.fatSaturated ?? "") ?? 0
        food.fibres = Float(item.fibres ?? "") ?? 0
        food.sodium = Float(item.sodium ?? "") ?? 0
        saveFood(context: context)
        
        print(item.name)
    }
    
    func deleteFood(food: FoodEntity, context: NSManagedObjectContext) {
        context.delete(food)
        saveFood(context: context)
    }
    
    func editFood(food: FoodEntity, name: String, calories: String, context: NSManagedObjectContext) {
        food.timestamp = Date()
        food.name = name
        food.energy = 0
        
        saveFood(context: context)
    }
}
