//
//  PushNotificationService.swift
//  WellNest
//
//  Created by Joshua Truong on 10/12/23.
//
import SwiftUI
import UserNotifications

class PushNotificationService: ObservableObject {
    @Published var isPermissionGranted: Bool = false
    @Published var notificationError: Bool = false
    @Published var scheduledTime: Date?

    @MainActor
    init() {
        checkPermissionStatus()
    }
    
    // Check notification permission status
    @MainActor
    private func checkPermissionStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            self.isPermissionGranted = settings.authorizationStatus == .authorized
        }
    }

    // Request notification permission
    @MainActor
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                self.isPermissionGranted = true
            } else if error != nil {
                self.notificationError = true
            }
        }
    }

    // Schedule a local notification
    @MainActor
    func scheduleNotification(title: String, body: String, time: Date) {
        requestNotificationPermission()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                self.notificationError = true
            }
        }
    }
    
    func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
