//
//  TimePickerView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/29/23.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        HStack {
            RangePicker(selected: $hour, min: 0, max: 13)
            RangePicker(selected: $minute, min: 0, max: 60)
            RangePicker(selected: $second, min: 0, max: 60)
        }
        .padding()
    }
}
