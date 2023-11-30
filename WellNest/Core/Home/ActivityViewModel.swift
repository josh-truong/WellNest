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
    private let activeDS = DataService<ActivityInfo>(key: .activeActivities)
    private let activitiesDS = DataService<ActivityInfo>(key: .activities)
    
    private let preloadActivities: [ActivityInfo] = [
        ActivityInfo(activity: Steps(), start: 0, end: 10000),
        ActivityInfo(activity: Running(), start: 0, end: 10000),
        ActivityInfo(activity: WeightLifting(), start: 0, end: 1000),
    ]
    
    private let activities: [ActivityInfo] = [
        ActivityInfo(activity: Steps(), start: 0, end: 10000),
        ActivityInfo(activity: Running(), start: 0, end: 10000),
        ActivityInfo(activity: WeightLifting(), start: 0, end: 1000),
        ActivityInfo(activity: Soccer(), start: 0, end: 300),
        ActivityInfo(activity: Basketball(), start: 0, end: 300),
        ActivityInfo(activity: StairStepper(), start: 0, end: 300),
        ActivityInfo(activity: Cycling(), start: 0, end: 300),
        ActivityInfo(activity: Hiking(), start: 0, end: 300)
    ]
    
    init() {
        setupDS()
    }
    
    func getActivitiesInfo() -> [ActivityInfo] {
        return activeDS.loadData() ?? [ActivityInfo]()
    }
    
    func preload() {
        if let loadedActivity = activeDS.loadData(), loadedActivity.isEmpty {
            print("Preloading activities")
            activeDS.saveDataList(preloadActivities)
        }
    }
    
    private func setupDS() {
        preload()
        if let loadedActivity = activitiesDS.loadData(), loadedActivity.isEmpty {
            print("Storing activities")
            activitiesDS.saveDataList(activities)
        }
    }
}
