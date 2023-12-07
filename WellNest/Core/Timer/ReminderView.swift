//
//  ReminderView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/3/23.
//

import SwiftUI
import UserNotifications

struct ReminderView: View {
    @Environment(\.dismiss) var dismiss
    @State var entity: FetchedResults<ActivityEntity>.Element
    @State private var selectedDate = Date()
    @State private var permissionDenied = false
    private let service = PushNotificationService()

    var body: some View {
        VStack {
            if (!permissionDenied) {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .disabled(permissionDenied)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
            }

            Button("Notify") {
                // Schedule notification if permission is granted
                service.checkPushNotificationStatus { isAuthorized in
                    if (!isAuthorized) {
                        service.requestPermission { status in
                            self.permissionDenied = status
                        }
                    }
                }
                
                if (!self.permissionDenied) {
                    service.scheduleNotification(title: "Time to Crush It 💪", body: "Your workout awaits!\n\(entity.activity.name)", time: selectedDate) { result in
                        switch result {
                        case .success(let identifier):
                            print("Notification scheduled successfully with identifier: \(identifier)")
                        case .failure(let error):
                            print("Failed to schedule notification with error: \(error)")
                        }
                    }
                }
                dismiss()
            }
            .padding()
        }
        .navigationTitle("Workout Reminder")
        .padding()
        .alert(isPresented: $permissionDenied) {
            Alert(
                title: Text("Permission Denied"),
                message: Text("Please enable notifications in Settings to receive reminders."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
