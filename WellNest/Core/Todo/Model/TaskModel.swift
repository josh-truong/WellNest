//
//  Destination.swift
//  WellNest
//
//  Created by Joshua Truong on 11/10/23.
//

import Foundation
import SwiftData

@Model
class TaskModel {
    var title: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var notes = [NotesModel]()
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 0) {
        self.title = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
