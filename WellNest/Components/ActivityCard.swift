//
//  ActivityCard.swift
//  WellNest
//
//  Created by Joshua Truong on 11/27/23.
//

import SwiftUI
import CoreData

struct ActivityCard: View {
    @Environment(\.managedObjectContext) var managedObjContext
    private var activity: Activity
    private var start: Int
    private var end: Int
    private var showProgress: Bool
    private var entity: FetchedResults<ActivityEntity>.Element?
    private var disableName: Bool
    
    var progressPercentage: CGFloat {
        guard end != 0 else { return 0 }
        if start >= end { return CGFloat(1.0) }
        return CGFloat(start) / CGFloat(end)
    }
    
    private init(activity: Activity, start: Int, end: Int, showProgress: Bool, disableName: Bool) {
        self.activity = activity
        self.start = start
        self.end = end
        self.showProgress = showProgress
        self.disableName = disableName
    }
    
    init(_ entity: FetchedResults<ActivityEntity>.Element, showProgress: Bool = true, disableName: Bool = false) {
        let activity = Activity(name: entity.name ?? "", image: entity.image ?? "", color: entity.color?.uiColor ?? .clear, unit: entity.unit ?? "", goal: 60)
        var start = 0
        entity.records?.forEach { record in
            let record = record as? ActivityInfoEntity
            if Calendar.current.isDateInToday(record?.timestamp ?? Date()) {
                start += Int(record?.elapsedSeconds ?? 0) / 60
            }
        }
        
        self.init(activity: activity, start: start, end: Int(entity.goal), showProgress: showProgress, disableName: disableName)
        self.entity = entity
    }
    
    init(_ activity: Activity, start: Int, end: Int, showProgress: Bool = true, disableName: Bool = false) {
        self.init(activity: activity, start: start, end: end, showProgress: showProgress, disableName: disableName)
    }
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment:  .leading, spacing: 5) {
                        if !disableName {
                            Text(activity.name)
                                .font(.system(size: 18))
                        }
                        if showProgress {
                            Text("Goal: \(end)")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.gray)
                                .padding(.top, 5)
                        }
                    }
                    Spacer()
                    
                    if !showProgress {
                        Text("\(start) \\ \(end) \(activity.unit)")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.gray)
                        Spacer()
                    }
                    
                    Image(systemName: activity.image)
                        .foregroundStyle(activity.color)
                }
                
                if showProgress {
                    ProgressView(value: progressPercentage) {
                        HStack {
                            Spacer()
                            Text(String(format: "%.0f%%", progressPercentage * 100))
                                .font(.system(size: 16))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .tint(activity.color)
                }
                
                if showProgress {
                    Text("\(start) \(activity.unit)")
                        .font(.system(size: 20))
                }
            }
            .padding()
        }
    }
}
