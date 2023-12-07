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
    @State var entity: FetchedResults<ActivityEntity>.Element
    @State private var selectedDate = Date()
    @State private var permissionDenied = false
    private let service = PushNotificationService()

    var body: some View {
        VStack {
            if (!permissionDenied) {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .disabled(permissionDenied)
                    .labelsHidden()
            }

            Button("Notify") {
                do {
                    // Schedule notification if permission is granted
                    service.checkPushNotificationStatus { isAuthorized in
                        permissionDenied = !isAuthorized
                        if (isAuthorized) {
                            service.scheduleNotification(title: "Time to Crush It 💪", body: "Your workout awaits!\n\(entity.activity.name)", time: selectedDate) { result in
                                switch result {
                                case .success(let identifier):
                                    print("Notification scheduled successfully for \(selectedDate) with identifier: \(identifier)")
                                    
                                    if let pushId = entity.pushID, !pushId.isEmpty {
                                        service.removeNotification(pushId)
                                    }
                                    entity.setPushNotificationId(identifier, context: managedObjContext)
                                    
                                case .failure(let error):
                                    print("Failed to schedule notification with error: \(error)")
                                }
                            }
                        }
                    }
                } catch {
                    print("Error with push notification: \(error.localizedDescription)")
                }
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
