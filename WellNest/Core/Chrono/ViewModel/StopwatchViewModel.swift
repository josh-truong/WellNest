//
//  StopwatchViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
class StopwatchViewModel : ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var displayMode: TimerMode = .setup
    @Published var mode: TimerMode = .setup
    
    private var timer: Timer?
    
    func start() {
        self.mode = .start
        self.displayMode = .pause
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.elapsedTime += 1
            }
        }
    }
    
    func pause() {
        mode = .pause
        displayMode = .resume
        
        timer?.invalidate()
        timer = nil
    }
    
    func resume() {
        mode = .resume
        displayMode = .pause
        start()
    }
    
    func finish() {
        mode = .finish
        displayMode = .start
        
        timer?.invalidate()
        timer = nil
    }
    
    func addRecord(_ entity: FetchedResults<ActivityEntity>.Element, context: NSManagedObjectContext) {
        entity.addToRecords(elapsedSeconds: Int(elapsedTime), context: context)
    }
}
