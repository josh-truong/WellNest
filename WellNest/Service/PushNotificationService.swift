//
//  PushNotificationService.swift
//  WellNest
//
//  Created by Joshua Truong on 10/12/23.
//
import SwiftUI
import UserNotifications

protocol NotificationService {
    // Method to request permission for push notifications
    func requestPermission(completion: @escaping (Bool) -> Void)

    // Method to schedule a notification
    func scheduleNotification(title: String, body: String, time: Date, completion: @escaping (Result<String, Error>) -> Void)
    
    func removeNotification(_ id: String)

    // Method to clear all scheduled notifications
    func clearNotifications()
}

class PushNotificationService: ObservableObject, NotificationService {
    
    func checkPushNotificationStatus(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let isAuthorized = settings.authorizationStatus == .authorized
            self.requestPermission { status in
                completion(isAuthorized)
            }
        }
    }


    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            completion(granted)
        }
    }

    func scheduleNotification(title: String, body: String, time: Date, completion: @escaping (Result<String, Error>) -> Void) {
        requestPermission { [weak self] granted in
            guard let self = self else { return }

            if granted {
                self.scheduleLocalNotification(title: title, body: body, time: time, completion: completion)
            } else {
                completion(.failure(NotificationError.permissionDenied))
            }
        }
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
