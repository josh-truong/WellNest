//
//  ChronoModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/15/23.
//

import Foundation
import SwiftUI

struct ChronoModel {
    var elapsed: TimeInterval = 0
    var progress: CGFloat { duration == 0 ? 1.0 : elapsed / duration }
    var remaining: TimeInterval { return max(0, duration - elapsed) }
    var duration: TimeInterval = 0
    var eta: Date = Date()
}
