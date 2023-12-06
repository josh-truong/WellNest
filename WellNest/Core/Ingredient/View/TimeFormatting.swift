//
//  TimeFormatting.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation

func timeSinceNow(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow) / 60
    
    if minutes == 0 {
        return "Just now"
    } else if minutes < 60 {
        return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
    } else if minutes < 120 {
        return "an hour ago"
    } else if minutes < 1440 {
        let hours = minutes / 60
        return "\(hours) hour\(hours == 1 ? "" : "s") ago"
    } else {
        let days = minutes / 1440
        return "\(days) day\(days == 1 ? "" : "s") ago"
    }
}
