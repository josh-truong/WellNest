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
    
    private let activeDS = DataService<ActivityInfo>(key: .activeActivities)
    private let activitiesDS = DataService<ActivityInfo>(key: .activities)
    
    init() {
        setupDS()
    }
    
    func getActiveActivities() {
        self.activeActivities = activeDS.loadData() ?? [ActivityInfo]()
    }
    
    func getInactiveActivities() {
        guard let loadedActivity = activitiesDS.loadData() else { return }
        guard let loadedActive = activeDS.loadData() else { return }
        
        let inactiveActivities = loadedActivity.filter { activity in
            !loadedActive.contains { $0.id == activity.id }
        }
        self.inactiveActivities = inactiveActivities
    }

    func addActivityToActive(_ item: ActivityInfo) {
        activeDS.addItem(item)
        getInactiveActivities()
        getActiveActivities()
    }
    
    func preload() {
        let preloadActivities: [ActivityInfo] = [
            ActivityInfo(activity: Steps(), start: 0, end: 10000),
            ActivityInfo(activity: Running(), start: 0, end: 10000),
            ActivityInfo(activity: WeightLifting(), start: 0, end: 1000),
        ]
        
        if let loadedActivity = activeDS.loadData(), loadedActivity.isEmpty {
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
        
        if let loadedActivity = activitiesDS.loadData(), loadedActivity.isEmpty {
            print("Storing activities")
            activitiesDS.saveDataList(activities)
        }
    }
    
    func clearActives() {
        activeDS.clearData()
        getActiveActivities()
    }
}
