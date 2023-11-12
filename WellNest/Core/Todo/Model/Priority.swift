//
//  PriorityType.swift
//  WellNest
//
//  Created by Joshua Truong on 11/9/23.
//

import SwiftUI
import Foundation

enum Priority: String, CaseIterable, Identifiable, Codable, Hashable {
    case none, low, medium, high
    var id: Self { self }
}

extension Priority {
    var name: String {
        switch self {
        case .none:
            return ""
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
            case .none:
                return Color.gray
            case .low:
                return Color.green
            case .medium:
                return Color.orange
            case .high:
                return Color.red
        }
    }
    
    var rank: Int {
        switch self {
            case .none:
                return 0
            case .low:
                return 1
            case .medium:
                return 2
            case .high:
                return 3
        }
    }
}
