//
//  WorkoutTaskView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/15/23.
//

import SwiftUI

struct WorkoutTaskView: View {
    @Binding var tasks: [WorkoutTask]
    @State private var toggleAlert = false
    
    var body: some View {
        ScrollView {
            ForEach(Array(tasks.enumerated()), id: \.1.id) { (index, task) in
                HStack {
                    Toggle(task.title, isOn: $tasks[index].isIncomplete)
                        .onChange(of: !task.isIncomplete) { newValue in
                            toggleAlert = newValue
                        }
                        .foregroundColor(!task.isIncomplete ? .gray : .primary)
                        .strikethrough(!task.isIncomplete)
                        .padding()
                        .alert(isPresented: $toggleAlert) {
                            Alert(
                                title: Text("Congrats!"),
                                message: Text(toggleAlert ? "Yay" : "Aww"),
                                dismissButton: .default(Text("Ok"))
                            )
                        }
                }
            }
        }
    }
}
