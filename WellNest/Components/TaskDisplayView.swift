//
//  TaskDisplayView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import SwiftUI

struct TaskDisplayView: View {
    let task: TaskModel
    var body: some View {
        NavigationLink(value: task) {
            HStack {
                Circle()
                    .fill(Priority.color(task.priority))
                    .frame(width: 8, height: 8)
                    .padding(.trailing, 8)
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                    Text(task.date.formatted(date: .long, time: .shortened))
                }
            }
        }
    }
}
