//
//  TodoModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/9/23.
//
import Foundation
import SwiftData

//@Model
//class TodosSection: Identifiable {
//    var id: Int { return UUID().hashValue }
//    var name: String
//    @Relationship(deleteRule: .cascade) var todos = [TodoItem]()
//    init() {}
//}

@Observable
class TodoItem: Identifiable {
    var id: Self { self }
    var title: String = ""
    var priority: Priority = .medium
    var date: Date = Date()
    var notes: String = ""
}
