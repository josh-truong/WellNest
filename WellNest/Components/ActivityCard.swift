//
//  ActivityCard.swift
//  WellNest
//
//  Created by Joshua Truong on 11/27/23.
//

import SwiftUI

struct ActivityCard: View {
    let activity: Activity
    var start: Int
    var end: Int
    var showProgress: Bool = true
    
    var progressPercentage: CGFloat {
        guard end != 0 else { return 0 }
        if (start >= end) { return CGFloat(1.0) }
        return CGFloat(start) / CGFloat(end)
    }
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment:  .leading, spacing: 5) {
                        Text(activity.name)
                            .font(.system(size: 18))
                        Text("Goal: \(end)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.gray)
                    }
                    Spacer()
                    
                    if (!showProgress) {
                        VStack {
                            Spacer()
                            Text("\(start) \(activity.unit)")
                                .font(.system(size: 20))
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    Image(systemName: activity.image)
                        .foregroundStyle(activity.color.uiColor)
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
                    .tint(activity.color.uiColor)
                    
                    Text("\(start) \(activity.unit)")
                        .font(.system(size: 20))
                }
            }
            .padding()
        }
    }
}
