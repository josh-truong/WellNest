//
//  TodoViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/9/23.
//

import Foundation
import SwiftData

class TodoViewModel: ObservableObject {
    @Published var todos = [TodoItem]()
    
    func addTodo() {
        todos.append(TodoItem())
        print("Added Todo")
    }
    
    func deleteTodo(indexSet: IndexSet) {
        todos.remove(atOffsets: indexSet)
        print("Removed Todo")
    }
    
    func moveTodo(indexSet: IndexSet, index: Int) {
        todos.move(fromOffsets: indexSet, toOffset: index)
    }
}
