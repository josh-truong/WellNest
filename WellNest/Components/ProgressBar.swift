//
//  ProgressBar.swift
//  WellNest
//
//  Created by Joshua Truong on 12/17/23.
//

import SwiftUI

struct ProgressBar: View {
    let name: String
    let start: Float
    let goal: Float
    let color: Color
    private var progress: Float { max(0, min(start / goal, 1)) }
    
    var body: some View {
        if goal == 0 {
            EmptyView()
        }
        else {
            ProgressView(value: progress) {
                HStack {
                    Circle()
                        .fill(color)
                        .frame(width: 10, height: 10)
                    Text(name)
                        .font(.system(size: 16))
                    Spacer()
                    
                    Text(String(format: "%.0f% / %.0f%", start, goal))
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)
                }
            }
            .tint(color)
        }
    }
}
