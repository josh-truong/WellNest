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
    @StateObject private var service = PushNotificationService()
    
    var body: some View {
        Form {
            TextField("Title", text: $task.title)
            TextField("Details", text: $task.details, axis: .vertical)
            
            HStack {
                Toggle("", isOn: $task.isNotificationEnabled)
                    .labelsHidden()
                    .onChange(of: task.isNotificationEnabled) {
                        if task.isNotificationEnabled {
                            service.checkPushNotificationStatus()
                            if (service.permissionStatus == .authorized) {
                                task.isNotificationEnabled = true
                            } else {
                                
                                
                            }
                        }
                    }
                
                Spacer()
                
                if task.isNotificationEnabled {
                    DatePicker("", selection: $task.date, displayedComponents: [.date, .hourAndMinute])
                        .disabled(!task.isNotificationEnabled)
                } else {
                    Text("Enable Push Notification")
                }
            }
        
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
        .onDisappear {
            if (task.isNotificationEnabled) {
                service.checkPushNotificationStatus()
                if (service.permissionStatus == .authorized) {
                    if !task.pushNotificationIdentifier.isEmpty {
                        service.removeNotification(task.pushNotificationIdentifier)
                        task.pushNotificationIdentifier = ""
                    }
                    service.scheduleNotification(title: task.title, body: task.details, time: task.date) { result in
                        switch result {
                        case .success(let identifier):
                            print("Notification scheduled successfully with identifier: \(identifier)")
                            task.pushNotificationIdentifier = identifier
                        case .failure(let error):
                            print("Failed to schedule notification with error: \(error)")
                        }
                    }
                }
            }
        }
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
