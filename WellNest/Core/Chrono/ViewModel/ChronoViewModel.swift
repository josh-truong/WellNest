//
//  ChronoViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/15/23.
//

import Foundation
import CoreData
import SwiftUI

class ChronoViewModel : ObservableObject, ChronoProtocol {
    @Published var displayMode: TimerMode = .setup
    @Published var mode: TimerMode = .setup
    @Published var isRunning: Bool = false
    @Published var model: ChronoModel = .init()
    @Published var type: ChronoType = .timer
    
    private var timer: Timer?
    private var context: NSManagedObjectContext?
    
    
    public var entity: FetchedResults<ActivityEntity>.Element?
    
    func setType(_ type: ChronoType) {
        self.type = type
    }
    
    func setupEntity(_ entity: FetchedResults<ActivityEntity>.Element, context: NSManagedObjectContext) {
        self.entity = entity
        self.context = context
    }
    
    func setup(_ hour: Int, _ minute: Int, _ second: Int) {
        mode = .setup
        self.model.duration = TimeInterval(hour*3600 + minute*60 + second)
    }
    
    func start() {
        isRunning = true
        mode = .start
        displayMode = .pause
        
        model.started = Date()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.model.elapsed += 1
                
                if self.type == .timer {
                    (self.model.elapsed > self.model.duration) ? self.finish() : ()
                }
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
        guard let entity = entity else { fatalError("Entity was not initialized.") }
        guard let context = context else { fatalError("NSManagedObjectContext was not initialized.") }
        
        entity.addToRecords(elapsedSeconds: Int(model.elapsed), context: context)
        reset()
    }
    
    func reset() {
        isRunning = false
        mode = .finish
        displayMode = .setup
        model.elapsed = 0
        
        timer?.invalidate()
        timer = nil
    }
}
