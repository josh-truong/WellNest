//
//  SubTodoModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/11/23.
//

import SwiftData
import Foundation

@Model
class NotesModel {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
