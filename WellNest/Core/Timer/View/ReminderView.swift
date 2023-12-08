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
    @ObservedObject var service: PushNotificationService = .init()
    let entity: FetchedResults<ActivityEntity>.Element
    @State var selectedDate: Date = Date()
    

    var body: some View {
        VStack {
            DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()

            Button("Notify") {
                service.scheduleNotification(title: "Test", body: "This is a test notification", time: Date()) { result in
                    switch result {
                    case .success(let identifier):
                        print("Notification scheduled with identifier: \(identifier)")
                    case .failure(let error):
                        print("Failed to schedule notification. Error: \(error.localizedDescription)")
                    }
                }
            }
            .padding()
        }
        .onAppear { service.checkPushNotificationStatus() }
        .navigationTitle("Workout Reminder")
        .padding()
        .alert(isPresented: .constant(false)) {
            Alert(
                title: Text("Permission Denied"),
                message: Text("Please enable notifications in Settings to receive reminders."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
