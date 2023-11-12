//
//  PriorityType.swift
//  WellNest
//
//  Created by Joshua Truong on 11/9/23.
//

import SwiftUI
import Foundation

class Priority {
    static func color(_ id: Int = 0) -> Color {
        switch id {
            case 0:
                return Color.gray
            case 1:
                return Color.green
            case 2:
                return Color.orange
            case 3:
                return Color.red
        default:
            return Color.gray
        }
    }
}
