//
//  TodoListingView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/11/23.
//

import SwiftData
import SwiftUI

struct TasksView: View {
    @Environment(\.modelContext) var context
    @Query(sort: [SortDescriptor(\TaskModel.priority, order: .reverse), SortDescriptor(\TaskModel.title)]) var tasks: [TaskModel]
    
    init(sort: SortDescriptor<TaskModel>) {
        _tasks = Query(sort: [sort])
    }
    
    var body: some View {
        List {
            HStack {
                Spacer()
                Button("Clear all", role: .destructive, action: clearTask)
            }
            ForEach(tasks) { task in
                TaskDisplayView(task: task)
            }
            .onDelete(perform: deleteTask(_:))
        }
    }
}

extension TasksView {
    func deleteTask(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = tasks[index]
            context.delete(destination)
        }
    }
    
    func clearTask() {
        do {
            try context.delete(model: TaskModel.self)
        } catch {}
    }
}

#Preview {
    TasksView(sort: SortDescriptor(\TaskModel.title))
}
