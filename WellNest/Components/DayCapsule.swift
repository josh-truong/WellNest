//
//  DaySelector.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import SwiftUI

struct DayCapsule: View {
    let date: Date
    var isSelected: Bool = false
    var isDisabled: Bool = false
    var onTap: () -> Void = {}

    var body: some View {
        RoundedRectangle(cornerRadius: 1000)
            .fill(isSelected ? Color.blue : Color.clear)
            .frame(width: 50, height: 80)
            .overlay(
                VStack {
                    Text(date.shortDayName)
                        .font(.system(size: 14))
                        .foregroundColor(isDisabled ? .black : (isSelected ? .white : .black))

                    Circle()
                        .fill(Color.white)
                        .opacity(isDisabled ? 0.5 : (isSelected ? 1.0 : 0.0))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("\(date.dayNumber)")
                                .font(.system(size: 18))
                        )
                }
            )
            .onTapGesture {
                if !isDisabled {
                    onTap()
                }
            }
            .opacity(isDisabled ? 0.5 : 1.0)
    }
}


#Preview {
    DayCapsule(date: Date(), isSelected: true, onTap: {})
}
