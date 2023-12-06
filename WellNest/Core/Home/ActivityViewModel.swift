//
//  ActivityViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class ActivityViewModel : ObservableObject {
    @Published var activeActivities = [ActivityInfo]()
    @Published var inactiveActivities = [ActivityInfo]()
    @Published var activities = [ActivityInfo]()
    
    private let activeDS = UserDefaultService<ActivityInfo>(key: .activeActivities)
    private let activitiesDS = UserDefaultService<ActivityInfo>(key: .activities)
    
    init() {
        setupDS()
    }
    
    func getActiveActivities() {
        self.activeActivities = activeDS.load() ?? [ActivityInfo]()
    }
    
    func getInactiveActivities() {
        guard let loadedActivity = activitiesDS.load() else { return }
        guard let loadedActive = activeDS.load() else { return }
        
        let inactiveActivities = loadedActivity.filter { activity in
            !loadedActive.contains { $0.id == activity.id }
        }
        self.inactiveActivities = inactiveActivities
    }

    func moveToActive(_ item: ActivityInfo) {
        activeDS.add(item)
        getInactiveActivities()
        getActiveActivities()
    }
    
    func moveToInctive(_ item: ActivityInfo) {
        activeDS.remove(item)
        getInactiveActivities()
        getActiveActivities()
    }
    
    func preload() {
        let preloadActivities: [ActivityInfo] = [
            ActivityInfo(activity: Steps(), start: 0, end: 10000),
            ActivityInfo(activity: Running(), start: 0, end: 10000),
            ActivityInfo(activity: WeightLifting(), start: 0, end: 1000),
        ]
        
        if let loadedActivity = activeDS.load(), loadedActivity.isEmpty {
            print("Preloading activities")
            activeDS.saveDataList(preloadActivities)
            getActiveActivities()
        }
    }
    
    private func setupDS() {
        preload()
        let activities: [ActivityInfo] = [
            ActivityInfo(activity: Steps(), start: 0, end: 10000),
            ActivityInfo(activity: Running(), start: 0, end: 10000),
            ActivityInfo(activity: WeightLifting(), start: 0, end: 1000),
            ActivityInfo(activity: Soccer(), start: 0, end: 300),
            ActivityInfo(activity: Basketball(), start: 0, end: 300),
            ActivityInfo(activity: StairStepper(), start: 0, end: 300),
            ActivityInfo(activity: Cycling(), start: 0, end: 300),
            ActivityInfo(activity: Hiking(), start: 0, end: 300)
        ]
        
        if let loadedActivity = activitiesDS.load(), loadedActivity.isEmpty {
            print("Storing activities")
            activitiesDS.saveDataList(activities)
        }
    }
    
    func move(from fromOffsets: IndexSet, to toOffset: Int) {
        activeDS.move(from: fromOffsets, to: toOffset)
        getActiveActivities()
    }
    
    func clearActives() {
        activeDS.clear()
        getActiveActivities()
    }
    
    func delete(from fromOffsets: IndexSet) {
        var deletedItems = fromOffsets.compactMap {
            self.inactiveActivities[$0]
        }
        activitiesDS.remove(deletedItems.removeFirst())
    }
}
