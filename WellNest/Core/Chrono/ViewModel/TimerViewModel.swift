//
//  StopwatchViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import Foundation
import CoreData
import SwiftUI

class TimerViewModel : ObservableObject {
    @Published var isRunning: Bool = false
    @Published var displayMode: TimerMode = .setup
    @Published var mode: TimerMode = .setup
    @Published var eta: Date = Date()
    @Published var progress: CGFloat = 0.0
    @Published var remainingDuration: TimeInterval = 0
    
    private var timer: Timer?
    
    private var duration: TimeInterval = 0
    private var elapsed: TimeInterval = 0
    
    func setup(hour: Int, minute: Int, second: Int) {
        mode = .setup
        duration = TimeInterval(hour*3600 + minute*60 + second)
        elapsed <= duration ? { start() }() : { pause() }()
    }
    
    func start() {
        isRunning = true
        mode = .start
        displayMode = .pause
        
        eta = Date().addingTimeInterval(duration)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            elapsed += 1
            remainingDuration = max(0, duration - elapsed)
            progress = elapsed / duration
            if elapsed >= duration {
                finish()
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
        isRunning = false
        mode = .finish
        displayMode = .setup
        eta = Date()
        progress = 0.0
        remainingDuration = 0.0
        duration = 0
        elapsed = 0
        
        timer?.invalidate()
        timer = nil
    }
    
    func addRecord(_ entity: FetchedResults<ActivityEntity>.Element, context: NSManagedObjectContext) {
        entity.addToRecords(elapsedSeconds: Int(elapsed), context: context)
    }
}
