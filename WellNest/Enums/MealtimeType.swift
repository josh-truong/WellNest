//
//  MealtimeType.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import Foundation
import SwiftUI

protocol MealtimeProtocol {
    var name: MealtimeType { get }
    var image: String { get }
    var color: Color { get }
}

enum MealtimeType : String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
}

struct Breakfast : MealtimeProtocol {
    let name: MealtimeType = .breakfast
    let image: String = "sun.horizon"
    let color: Color = .yellow
}


struct Lunch : MealtimeProtocol {
    let name: MealtimeType = .lunch
    let image: String = "sun.max"
    let color: Color = .blue
}


struct Dinner : MealtimeProtocol {
    let name: MealtimeType = .dinner
    let image: String = "moon.haze"
    let color: Color = .purple
}
