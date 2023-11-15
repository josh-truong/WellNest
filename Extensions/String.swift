//
//  String.swift
//  WellNest
//
//  Created by Joshua Truong on 11/15/23.
//

import Foundation

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
