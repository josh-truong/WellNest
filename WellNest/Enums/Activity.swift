//
//  Activity.swift
//  WellNest
//
//  Created by Joshua Truong on 11/27/23.
//

import Foundation
import SwiftUI

//  Activity.swift
//  WellNest
//
//  Created by Joshua Truong on 11/27/23.

import Foundation
import SwiftUI

protocol Activity {
    var name: String { get }
    var image: String { get }
    var color: Color { get }
    var unit: String { get }
    //var content: View { get }
}

struct ActivityInfo: Identifiable {
    var id: Int { return UUID().hashValue }
    var activity: Activity
    var start: Int
    var end: Int
}

struct Steps: Activity {
    let name = "Today steps"
    let image = "figure.walk"
    let color = Color.green
    let unit = "steps"
}

struct Water: Activity {
    let name = "Glasses"
    let image = "drop.fill"
    let color = Color.blue
    let unit = "glasses"
}


struct Calories: Activity {
    let name = "Calories"
    let image = "flame"
    let color = Color.red
    let unit = "calories"
}

struct Running: Activity {
    let name = "Running"
    let image = "figure.run"
    let color = Color.purple
    let unit = "minutes"
}

struct WeightLifting: Activity {
    let name = "Weight Lifting"
    let image = "dumbbell"
    let color = Color.cyan
    let unit = "minutes"
}

struct Soccer: Activity {
    let name = "Soccer"
    let image = "figure.soccer"
    let color = Color.blue
    let unit = "minutes"
}

struct Basketball: Activity {
    let name = "Basketball"
    let image = "figure.basketball"
    let color = Color.orange
    let unit = "minutes"
}

struct StairStepper: Activity {
    let name = "Stair Stepper"
    let image = "figure.stair.stepper"
    let color = Color.green
    let unit = "minutes"
}

struct Cycling: Activity {
    let name = "Cycling"
    let image = "figure.outdoor.cycle"
    let color = Color.orange
    let unit = "minutes"
}

struct Hiking: Activity {
    let name = "Hiking"
    let image = "figure.hiking"
    let color = Color.mint
    let unit = "minutes"
}
