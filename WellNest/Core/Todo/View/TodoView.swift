//
//  TaskView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/9/23.
//

import SwiftUI

struct TodoView: View {
    @Bindable var todo: TodoItem
    @State private var isToggled = false
    @State private var screenWidth: CGFloat = 0
    
    var body: some View {
        if (!isToggled) {
            HStack {
                
                Spacer()
                
                DatePicker("", selection: $todo.date, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
                
                Spacer()
                
                Button {
                    isToggled.toggle()
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
 
            TextField("Enter task name", text: $todo.title)
                .onTapGesture {}
                .onSubmit { isToggled.toggle() }
                .textFieldStyle(PlainTextFieldStyle())
            
            Picker("", selection: $todo.priority) {
                ForEach(Priority.allCases) { priority in
                    Text(priority.title).tag(priority)
                }
            }
            .pickerStyle(.segmented)
            
            TextEditor(text: $todo.notes)
                .frame(height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onTapGesture {}
                .textFieldStyle(PlainTextFieldStyle())
        } else {
            HStack {
                Circle()
                    .fill(todo.priority.color)
                    .frame(width: 8, height: 8)
                Text(todo.title)
            }
            .onTapGesture {
                isToggled.toggle()
            }
        }
    }
}
