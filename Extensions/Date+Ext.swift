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
}
