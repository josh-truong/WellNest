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
                    if task.isNotificationEnabled {
                        let date = task.date
                        if (isPastDue(date)) {
                            Text("Task is past due!")
                                .foregroundStyle(Color.red)
                        }
                        else if isToday(date) {
                            Text("Reminder at \(date.formatted(date: .omitted, time: .shortened))")
                        }
                        else if (isWithin7Days(date)) {
                            Text("Reminder on \(dayOfWeek(date)) at \(date.formatted(date: .omitted, time: .shortened))")
                        }
                        else {
                            Text("\(date.formatted(date: .abbreviated, time: .shortened))")
                        }
                    }
                }
            }
        }
    }
}

extension TaskDisplayView {
    var customDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: "2023/11/15 07:00") ?? Date()
    }
    
    func isPastDue(_ date: Date) -> Bool {
        return date < Date.now
    }
    
    func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
    
    func isWithin7Days(_ date: Date) -> Bool {
        if let week = Calendar.current.date(byAdding: .day, value: 6, to: .now) {
            return date <= week
        }
        return false
    }
    
    func dayOfWeek(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}
