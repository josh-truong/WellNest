//
//  TimeInterval+Ext.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import Foundation

extension TimeInterval {
    func toString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]

        return formatter.string(from: self) ?? ""
    }
}
