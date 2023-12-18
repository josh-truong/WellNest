//
//  CustomSlider.swift
//  WellNest
//
//  Created by Joshua Truong on 12/17/23.
//

import SwiftUI

struct CustomSlider: View {
    let name: String
    let color: Color
    @Binding var value: Float
    let min: Float
    let max: Float
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 10, height: 10)
                Text(name)
                    .subtitle()
                Spacer()
                Text(String(format: "%.0f", value))
                    .subtitle()
            }
            Slider(value: $value, in: min...max, step: 1)
                .tint(color)
        }
    }
}
