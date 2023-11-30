//
//  TimerViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation
import Combine

@MainActor
class TimerViewModel : ObservableObject {
    private var timerService: TimerService
    
    @Published var mode: TimerMode = .setup
    @Published var isFinished: Bool = false
    @Published var timeRemainingFormatted: String = ""
    @Published var eta: String = ""
    @Published var progress: CGFloat = 0.0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.timerService = TimerService()
        setupSubscriptions()
    }

    func startTimer(hour: Int, minute: Int, second: Int) {
        timerService.setupTimer(hour: hour, minute: minute, second: second)
    }

    func finishTimer() {
        timerService.finishTimer()
    }

    func pauseTimer() {
        timerService.pauseTimer()
    }

    func resumeTimer() {
        timerService.resumeTimer()
    }
    
    private func setupSubscriptions() {
        timerService.$mode
            .sink { [weak self] mode in
                DispatchQueue.main.async {
                    self?.mode = mode
                }
            }
            .store(in: &cancellables)
        
        timerService.$isFinished
            .sink { [weak self] isFinished in
                DispatchQueue.main.async {
                    self?.isFinished = isFinished
                }
            }
            .store(in: &cancellables)
        
        timerService.$timeRemainingFormatted
            .sink { [weak self] timeRemainingFormatted in
                DispatchQueue.main.async {
                    self?.timeRemainingFormatted = timeRemainingFormatted
                }
            }
            .store(in: &cancellables)
        
        timerService.$eta
            .sink { [weak self] eta in
                DispatchQueue.main.async {
                    self?.eta = eta
                }
            }
            .store(in: &cancellables)
        
        timerService.$progress
            .sink { [weak self] progress in
                DispatchQueue.main.async {
                    self?.progress = progress
                }
            }
            .store(in: &cancellables)
    }
}
