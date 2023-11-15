//
//  EditTodo.swift
//  WellNest
//
//  Created by Joshua Truong on 11/10/23.
//

import SwiftUI
import SwiftData

struct EditTaskView: View {
    @Bindable var task: TaskModel
    @State private var newNoteTitle = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $task.title)
            TextField("Details", text: $task.details, axis: .vertical)
            DatePicker("", selection: $task.date)

            Section("Priority") {
                Picker("Priority", selection: $task.priority) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Notes") {
                ForEach(task.notes) { note in
                    Text(note.name)
                }
                .onDelete(perform: deleteNote)
                
                HStack {
                    TextField("Add a note", text: $newNoteTitle)
                    Button("Add", action: addNote)
                }
            }
        }
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension EditTaskView {
    func deleteNote(_ indexSet: IndexSet) {
        for index in indexSet {
            task.notes.remove(at: index)
        }
    }
    
    func addNote() {
        guard !newNoteTitle.isEmpty else { return }
        withAnimation {
            task.notes.append(NotesModel(name: newNoteTitle))
            newNoteTitle = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: TaskModel.self, configurations: config)
        let example = TaskModel(name: "name", details: "details")
        return EditTaskView(task: example)
            .modelContainer(container)
    } catch {
        fatalError("")
    }
}
