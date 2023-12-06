//
//  RecordManager.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation
import CoreData
import SwiftUI


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
    let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "RecordModel")
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
}

extension FoodEntity {
    func add(item: WgerIngredientResult, context: NSManagedObjectContext) {
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
        save(context: context)
    }
    
    func delete(item: FoodEntity, context: NSManagedObjectContext) {
        context.delete(item)
        save(context: context)
    }
    
    func update(item: FoodEntity, name: String, calories: String, context: NSManagedObjectContext) {
        item.timestamp = Date()
        item.name = name
        item.energy = 0
        
        save(context: context)
    }
    
    private func save(context: NSManagedObjectContext) {
        do { try context.save() }
        catch { print("Data not saved! \(error.localizedDescription)") }
    }
}


extension ActivityEntity {
    var activity: Activity {
        return Activity(name: name ?? "", image: image ?? "", color: color?.uiColor ?? .clear, unit: unit ?? "")
    }
    
    func add(name: String, image: String, unit: String, uiColor: Color, context: NSManagedObjectContext) {
        let colorEntity = ColorEntity(context: context)
        let rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = colorEntity.rgba(color: uiColor)
        colorEntity.red = rgba.red
        colorEntity.green = rgba.green
        colorEntity.blue = rgba.blue
        colorEntity.alpha = rgba.alpha
        
        let entity = ActivityEntity(context: context)
        entity.uuid = UUID()
        entity.name = name
        entity.image = image
        entity.unit = unit
        entity.color = colorEntity
        
        save(context: context)
    }
    
    func addToRecords(elaspedTime: Date, context: NSManagedObjectContext) {
        let entity = ActivityInfoEntity(context: context)
        entity.uuid = UUID()
        entity.timestamp = Date()
        entity.elapsedTime = elaspedTime
        
        addToRecords(entity)
        save(context: context)
    }
    
    private func save(context: NSManagedObjectContext) {
        do { try context.save() }
        catch { print("Data not saved! \(error.localizedDescription)") }
    }
}

extension ColorEntity {
    var uiColor: Color {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    func rgba(color: Color) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let uiColor = UIColor(color)
        var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = (0,0,0,0)
        uiColor.getRed(&rgba.red, green: &rgba.green, blue: &rgba.blue, alpha: &rgba.alpha)
        
        return (rgba.red, rgba.green, rgba.blue, rgba.alpha)
    }
}
