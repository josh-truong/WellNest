//
//  Activity.swift
//  WellNest
//
//  Created by Joshua Truong on 11/27/23.
//

import Foundation
import SwiftUI

struct CodableColor: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double

    init(_ color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
        self.opacity = Double(alpha)
    }

    var uiColor: Color {
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}

class Activity: Identifiable, Codable {
    var id: Int { return UUID().hashValue }
    var name: String
    var image: String
    var color: CodableColor
    var unit: String

    init(name: String, image: String, color: CodableColor, unit: String) {
        self.name = name
        self.image = image
        self.color = color
        self.unit = unit
    }

    // If you have additional initialization logic after decoding, you can implement this method
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        color = try container.decode(CodableColor.self, forKey: .color)
        unit = try container.decode(String.self, forKey: .unit)
    }

    // If you have additional encoding logic, you can implement this method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(color, forKey: .color)
        try container.encode(unit, forKey: .unit)
    }

    // CodingKeys enum to specify the coding keys
    private enum CodingKeys: String, CodingKey {
        case name
        case image
        case color
        case unit
    }
}


class ActivityInfo: Codable {
    var id: Int
    var activity: Activity
    var start: Int
    var end: Int

    init(activity: Activity, start: Int, end: Int) {
        self.id = UUID().hashValue
        self.activity = activity
        self.start = start
        self.end = end
    }

    // If you want to customize the coding keys, you can implement the CodingKey enum
    private enum CodingKeys: String, CodingKey {
        case id
        case activity
        case start
        case end
    }

    // If you have additional initialization logic after decoding, you can implement this method
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        activity = try container.decode(Activity.self, forKey: .activity)
        start = try container.decode(Int.self, forKey: .start)
        end = try container.decode(Int.self, forKey: .end)
    }

    // If you have additional encoding logic, you can implement this method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(activity, forKey: .activity)
        try container.encode(start, forKey: .start)
        try container.encode(end, forKey: .end)
    }
}

class Custom: Activity {
    init() {
        super.init(name: "Custom", image: "figure", color: CodableColor(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Steps: Activity {
    init() {
        super.init(name: "Today steps", image: "figure.walk", color: CodableColor(Color.green), unit: "steps")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Water: Activity {
    init() {
        super.init(name: "Glasses", image: "drop.fill", color: CodableColor(Color.blue), unit: "glasses")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Calories: Activity {
    init() {
        super.init(name: "Calories", image: "flame", color: CodableColor(Color.red), unit: "calories")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Running: Activity {
    init() {
        super.init(name: "Running", image: "figure.run", color: CodableColor(Color.purple), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class WeightLifting: Activity {
    init() {
        super.init(name: "Weight Lifting", image: "dumbbell", color: CodableColor(Color.cyan), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Soccer: Activity {
    init() {
        super.init(name: "Soccer", image: "figure.soccer", color: CodableColor(Color.blue), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Basketball: Activity {
    init() {
        super.init(name: "Basketball", image: "figure.basketball", color: CodableColor(Color.orange), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class StairStepper: Activity {
    init() {
        super.init(name: "Stair Stepper", image: "figure.stair.stepper", color: CodableColor(Color.green), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Cycling: Activity {
    init() {
        super.init(name: "Cycling", image: "figure.outdoor.cycle", color: CodableColor(Color.orange), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Hiking: Activity {
    init() {
        super.init(name: "Hiking", image: "figure.hiking", color: CodableColor(Color.mint), unit: "minutes")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
