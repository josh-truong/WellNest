//
//  PriorityType.swift
//  WellNest
//
//  Created by Joshua Truong on 11/9/23.
//

import SwiftUI
import Foundation

enum Priority: String, Identifiable, CaseIterable {
    case low, medium, high
    var id: Self { self }
}

extension Priority {
    var title: String {
        switch self {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
        }
    }
    
    var color: Color {
        switch self {
            case .low:
                return Color.green
            case .medium:
                return Color.orange
            case .high:
                return Color.red
        }
    }
}
