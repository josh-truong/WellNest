//
//  WellNestApp.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import CoreData
import SwiftData
import FirebaseCore

class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true;
    }
}

@main
struct WellNestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var auth: AuthViewModel = .init()
    @StateObject var firebase: FirebaseManager = .init()
    @StateObject private var recordManager = RecordManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)
                .environmentObject(firebase)
                .environment(\.managedObjectContext, recordManager.persistentContainer.viewContext)
        }
        .modelContainer(for: TaskModel.self)
    }
}
