//
//  TimeModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import Foundation

struct TimeModel : Equatable {
    var hr: Int = 0
    var min: Int = 0
    var sec: Int = 0
    
    public static func ==(lhs: TimeModel, rhs: TimeModel) -> Bool {
        return lhs.hr == rhs.hr && lhs.min == rhs.min && lhs.sec == rhs.sec
    }
}
