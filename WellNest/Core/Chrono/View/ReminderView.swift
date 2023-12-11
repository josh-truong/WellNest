//
//  ReminderView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/3/23.
//

import SwiftUI
import UserNotifications

struct ReminderView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @StateObject var service: PushNotificationService = .init()
    let entity: FetchedResults<ActivityEntity>.Element
    @State var selectedDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()

                Button("Notify") {
                    service.scheduleNotification(title: "Get Moving! It's Workout Time 💪", body: "🏋️‍♂️ Let's crush \(entity.name ?? "") together! 🏋️‍♀️\n#FitLife #YouGotThis #WorkoutReminder", time: selectedDate) { result in
                        switch result {
                        case .success(let identifier):
                            if let pushId = entity.pushID, !pushId.isEmpty {
                                service.removeNotification(identifier)
                            }
                            entity.setPushNotificationId(identifier, context: managedObjContext)
                            service.getPendingNotificationRequests()
                            print("Notification scheduled with identifier: \(identifier)")
                        case .failure(let error):
                            print("Failed to schedule notification. Error: \(error.localizedDescription)")
                        }
                    }
                }
                .padding(10)
                
                if (!service.pendingNotificationRequests.isEmpty) {
                    VStack(alignment: .leading) {
                        Text("Pending Notifications")
                            .font(.headline)
                            .padding()
                        List {
                            ForEach(service.pendingNotificationRequests, id: \.identifier) { request in
                                ReminderCard(request: request)
                                    .listRowSeparator(.hidden)
                            }
                            .onDelete(perform: { indexSet in
                                for index in indexSet {
                                    service.removeNotification(service.pendingNotificationRequests[index].identifier)
                                }
                            })
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Set a reminder")
        }
        .onAppear {
            service.checkPushNotificationStatus()
            service.getPendingNotificationRequests()
        }
        .alert(isPresented: $service.isDenied) {
            Alert(
                title: Text("Permission Denied"),
                message: Text("Please enable notifications in Settings to receive reminders."),
                dismissButton: .default(Text("OK"), action: { dismiss() })
            )
        }
    }
}
