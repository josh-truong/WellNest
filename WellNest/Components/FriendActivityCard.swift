//
//  FriendActivityCard.swift
//  WellNest
//
//  Created by Joshua Truong on 12/14/23.
//

import SwiftUI

struct FriendActivityCard: View {
    let name: String
    let image: String
    let start: Int
    let end: Int
    let unit: String
    private let color: Color = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    private var progressPercentage: CGFloat {
        guard end != 0 else { return 0 }
        if start >= end { return CGFloat(1.0) }
        return CGFloat(start) / CGFloat(end)
    }
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(spacing: 10) {
                HStack(alignment: .top) {
                    Text(name)
                        .font(.system(size: 18))
                    Spacer()
                    Text("\(start) \\ \(end) \(unit)")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray)
                    
                    Image(systemName: image)
                        .foregroundStyle(color)
                }
                
                ProgressView(value: progressPercentage)
                    .tint(color)
            }
            .padding()
        }
    }
}
