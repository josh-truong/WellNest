//
//  AddWorkoutTaskView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/15/23.
//

import SwiftUI

struct AddWorkoutTaskView: View {
    @Binding var tasks: [WorkoutTask]
    @State private var task = ""
    
    var body: some View {
        TextField("New Workout Task", text: $task)
        HStack {
            Spacer()
            Button("Add Task", action: addTask)
                .buttonStyle(.bordered)
                .disabled(task.isEmpty)
        }
    }
    
    func addTask()
    {
        if (!task.isEmpty) {
            tasks.append(WorkoutTask(title: task))
            task = ""
        }
    }
}
