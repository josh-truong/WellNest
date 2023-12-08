//
//  PushNotificationService.swift
//  WellNest
//
//  Created by Joshua Truong on 10/12/23.
//
import SwiftUI
import UserNotifications

class PushNotificationService: ObservableObject {
    @Published var permissionStatus: UNAuthorizationStatus = .denied
    
    func checkPushNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.permissionStatus = settings.authorizationStatus

                if self.permissionStatus == .notDetermined {
                    self.requestPermission()
                }
            }
        }
    }


    private func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            self.permissionStatus = granted ? .authorized : .denied
        }
    }
    
    func scheduleNotification(title: String, body: String, time: Date, completion: @escaping (Result<String, Error>) -> Void) {
        scheduleLocalNotification(title: title, body: body, time: time, completion: completion)
    }
    
    func removeNotification(_ id: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            if requests.contains(where: { $0.identifier == id }) {
                print("Removed \(id)")
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
            }
        }
    }

    func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func scheduleLocalNotification(title: String, body: String, time: Date, completion: @escaping (Result<String, Error>) -> Void) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(request.identifier))
            }
        }
    }
}

enum NotificationError: Error {
    case permissionDenied
}
