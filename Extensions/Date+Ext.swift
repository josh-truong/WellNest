//
//  Date+Ext.swift
//  WellNest
//
//  Created by Joshua Truong on 12/7/23.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    var endOfDay: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date()) ?? Date()
    }
    
    func relativeTime(in locale: Locale = .current) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    var oneWeekAgo : ClosedRange<Date> {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -6, to: self) ?? self
        return oneWeekAgo...self
    }
    
    var shortDayName : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
    
    var dayNumber: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day ?? 1
    }
    
    func timeAgo(date: Date) -> String {
        let minutes = Int(Date().timeIntervalSince(date)) / 60
        
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
    
    func toStringCivilian() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        return formatter.string(from: self)
    }
}
