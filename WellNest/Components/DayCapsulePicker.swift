//
//  DayCapsulePicker.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import SwiftUI

struct DayCapsulePicker: View {
    let dateRange: [Date]
    @Binding var selection: Date
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(dateRange, id: \.self) { date in
                    DayCapsule(date: date, isSelected: selection == date) {
                        withAnimation {
                            selection = date
                        }
                     }
                }
                nextDayCapsule
            }
        }
    }
    
    private var nextDayCapsule: some View {
        let latest = dateRange.sorted().last ?? Date()
        let to = Calendar.current.isDateInToday(latest) ? Date() : latest
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: to) ?? Date()
        return DayCapsule(date: nextDate, isDisabled: true)
    }
}

