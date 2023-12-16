//
//  CGFloat+Ext.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import Foundation

extension CGFloat {
    var formattedString: String {
        let formattedValue = String(format: "%.2f", self)
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(self)) : formattedValue.trimmingCharacters(in: ["0", "."])
    }
}
