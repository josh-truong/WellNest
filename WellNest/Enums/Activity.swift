//
//  Activity.swift
//  WellNest
//
//  Created by Joshua Truong on 11/27/23.
//

import Foundation
import SwiftUI

class Activity: Identifiable {
    var id: Int
    var name: String
    var image: String
    var color: Color
    var unit: String
    var goal: Int

    init(name: String, image: String, color: Color, unit: String, goal: Int) {
        self.id = UUID().hashValue
        self.name = name
        self.image = image
        self.color = color
        self.unit = unit
        self.goal = goal
    }
}


class ActivityInfo: Identifiable, Equatable {
    var id: Int
    var activity: Activity
    var end: Int

    init(activity: Activity, goal: Int) {
        self.id = UUID().hashValue
        self.activity = activity
        self.end = goal
    }
    
    static func == (lhs: ActivityInfo, rhs: ActivityInfo) -> Bool {
        return lhs.id == rhs.id
    }
}

class Custom: Activity {
    init() {
        super.init(name: "Custom", image: "figure", color: Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)), unit: "minutes", goal: 6000)
    }
}

class Steps: Activity {
    init() {
        super.init(name: "Today steps", image: "figure.walk", color: Color.green, unit: "minutes", goal: 10000)
    }
}

class Water: Activity {
    init() {
        super.init(name: "Glasses", image: "drop.fill", color: Color.blue, unit: "glasses", goal: 8)
    }
}

class Weight: Activity {
    init() {
        super.init(name: "Weight", image: "scalemass.fill", color: Color.gray, unit: "lbs", goal: 200)
    }
}

class Calories: Activity {
    init() {
        super.init(name: "Calories", image: "flame", color: Color.red, unit: "calories", goal: 2500)
    }
}

class Running: Activity {
    init() {
        super.init(name: "Running", image: "figure.run", color: Color.purple, unit: "minutes", goal: 30)
    }
}

class WeightLifting: Activity {
    init() {
        super.init(name: "Weight Lifting", image: "dumbbell", color: Color.cyan, unit: "minutes", goal: 250)
    }
}

class Soccer: Activity {
    init() {
        super.init(name: "Soccer", image: "figure.soccer", color: Color.blue, unit: "minutes", goal: 120)
    }
}

class Basketball: Activity {
    init() {
        super.init(name: "Basketball", image: "figure.basketball", color: Color.orange, unit: "minutes", goal: 120)
    }
}

class StairStepper: Activity {
    init() {
        super.init(name: "Stair Stepper", image: "figure.stair.stepper", color: Color.green, unit: "minutes", goal: 30)
    }
}

class Cycling: Activity {
    init() {
        super.init(name: "Cycling", image: "figure.outdoor.cycle", color: Color.orange, unit: "minutes", goal: 60)
    }
}

class Hiking: Activity {
    init() {
        super.init(name: "Hiking", image: "figure.hiking", color: Color.mint, unit: "minutes", goal:180)
    }
}
