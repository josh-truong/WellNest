//
//  ContinuousWheelPicker.swift
//  WellNest
//
//  Created by Joshua Truong on 11/29/23.
//

import SwiftUI

struct RangePicker: View {
    @Binding var selected: Int
    
    let min: Int
    let max: Int
    
    var body: some View {
        Picker("", selection: $selected) {
            ForEach(min ..< max, id: \.self) {
                Text(String(format: "%02d", $0))
            }
        }
        .padding()
        .pickerStyle(WheelPickerStyle())
        .labelsHidden()
        .frame(width: 80)
        .scaleEffect(CGSize(width: 2, height: 2))
    }
}
