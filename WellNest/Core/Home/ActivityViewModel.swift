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
    private let preloadActivities: [ActivityInfo] = [
        ActivityInfo(activity: Steps(), start: 6545, end: 10000),
        ActivityInfo(activity: Calories(), start: 6545, end: 10000),
        ActivityInfo(activity: Running(), start: 6545, end: 10000),
        ActivityInfo(activity: WeightLifting(), start: 6545, end: 10000),
        ActivityInfo(activity: Cycling(), start: 6545, end: 10000),
        ActivityInfo(activity: Hiking(), start: 6545, end: 10000),
        ActivityInfo(activity: Water(), start: 6545, end: 10000),
    ]
    
    func preload() {
        do {
            let activitiesDS = DataService<ActivityInfo>(key: "activities")
            activitiesDS.saveDataList(preloadActivities)
            
            // Retrieve and print updated list of data
            if let loadedActivity = activitiesDS.loadListData() {
                for info in loadedActivity {
                    print("Name: \(info.activity.name), Start: \(info.start), End: \(info.end)")
                }
            }
            
            
            
            
//            let container = try ModelContainer(for: ActivityInfo.self)
//            
//            var fetchDescriptor = FetchDescriptor<ActivityInfo>()
//            fetchDescriptor.fetchLimit = 1
//            
//            guard try container.mainContext.fetch(fetchDescriptor).count == 0 else { return }
//            
//            for activity in preloadActivities {
//                container.mainContext.insert(activity)
//            }
        }
        catch {
            fatalError("Failed to preload activities.")
        }
    }
}
