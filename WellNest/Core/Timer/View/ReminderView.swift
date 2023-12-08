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
                service.checkPushNotificationStatus()
                if (service.permissionStatus == .authorized) {
                    service.scheduleNotification(title: "Time to Crush It 💪", body: "Your workout awaits!\n\(entity.activity.name)", time: selectedDate) { result in
                        switch result {
                        case .success(let identifier):
                            print("Notification scheduled successfully for \(selectedDate) with identifier: \(identifier)")
                            
                            if let pushId = entity.pushID, !pushId.isEmpty { service.removeNotification(pushId) }
                            entity.setPushNotificationId(identifier, context: managedObjContext)
                        case .failure(let error):
                            print("Failed to schedule notification with error: \(error)")
                        }
                    }
                }
            }
            .padding()
        }
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
