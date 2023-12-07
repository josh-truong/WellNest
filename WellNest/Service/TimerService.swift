//
//  TimerService.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation

enum TimerMode {
    case setup
    case start
    case pause
    case resume
    case finish
}

class TimerService : ObservableObject {
    private var timer: Timer?
    private var startTime: Date?
    private var pauseTime: Date?
    private var endTime: Date?
    private var countdown: (hour: Int, minute: Int, second: Int) = (0,0,0)
    
    @Published var mode: TimerMode = .setup
    @Published var isFinished: Bool = false
    @Published var timeRemainingFormatted: String = ""
    @Published var eta: String = ""
    @Published var progress: CGFloat = 0.0

    func setupTimer(hour: Int, minute: Int, second: Int) {
        mode = .setup
        countdown = (hour, minute, second)
        let currentDate = Date()
        startTime = currentDate
        endTime = currentDate.addingTimeInterval(TimeInterval(hour * 3600 + minute * 60 + second))

        updateETA()
        updateFormattedTime()

        if let endTime = endTime, endTime > currentDate {
            let timeInterval = endTime.timeIntervalSince(currentDate)
            startTimer(timeInterval: timeInterval)
        } else {
            finishTimer()
        }
    }
    
    func calculateElapsedSeconds() -> Int {
        let remaining = extractComponents(from: timeRemainingFormatted)
        let remainingSeconds = remaining.hour * 3600 + remaining.minute * 60 + remaining.second
        let countdownSeconds = countdown.hour * 3600 + countdown.minute * 60 + countdown.second
        let elapsedSeconds = countdownSeconds - remainingSeconds
        return (elapsedSeconds >= 0) ? elapsedSeconds : countdownSeconds
    }

    private func startTimer(timeInterval: TimeInterval) {
        mode = .start
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            if let endTime = self.endTime {
                let remainingTime = max(endTime.timeIntervalSinceNow, 0)
                self.updateFormattedTime()
                self.updateProgressPercentage()

                if remainingTime == 0 {
                    self.finishTimer()
                }
            }
        }
    }

    func finishTimer() {
        mode = .finish
        timer?.invalidate()
        isFinished = true
    }

    func pauseTimer() {
        mode = .pause
        timer?.invalidate()
        pauseTime = Date()
    }

    func resumeTimer() {
        guard let startTime = startTime else { return }
        guard let pauseTime = pauseTime else { return }
        mode = .resume

        let currentDate = Date()
        let elapsedTimePaused = currentDate.timeIntervalSince(pauseTime)
        let adjustedEndTime = endTime?.addingTimeInterval(elapsedTimePaused)

        self.startTime = startTime.addingTimeInterval(elapsedTimePaused)
        self.endTime = adjustedEndTime

        if let adjustedEndTime = self.endTime {
            let remainingTime = max(adjustedEndTime.timeIntervalSinceNow, 0)
            updateETA()
            updateFormattedTime()
            startTimer(timeInterval: remainingTime)
        }
    }

    private func updateProgressPercentage() {
        guard let startTime = startTime else { return }
        guard let endTime = endTime else { return }

        let totalTime = endTime.timeIntervalSince(startTime)
        let elapsedTime = startTime.timeIntervalSinceNow

        if totalTime > 0 {
            let percentage = abs(CGFloat(elapsedTime)) / CGFloat(totalTime)
            self.progress = max(0.0, min(1.0, percentage))
        } else {
            self.progress = 1.0
        }
    }

    private func updateETA() {
        guard let endTime = endTime else { return }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        self.eta = formatter.string(from: endTime)
    }

    private func updateFormattedTime() {
        if let endTime = endTime {
            let remainingTime = max(endTime.timeIntervalSinceNow, 0)
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            formatter.allowedUnits = [.hour, .minute, .second]

            if let formattedString = formatter.string(from: remainingTime) {
                timeRemainingFormatted = formattedString
            }
        }
    }
    
    private func extractComponents(from formattedString: String) -> (hour: Int, minute: Int, second: Int) {
        let components = formattedString.components(separatedBy: ":")
        var time: (hour: Int, minute: Int, second: Int) = (0,0,0)
        switch (components.count) {
        case 1:
            time.second = Int(components[0]) ?? 0
        case 2:
            time.minute = Int(components[0]) ?? 0
            time.second = Int(components[1]) ?? 0
        case 3:
            time.hour = Int(components[0]) ?? 0
            time.minute = Int(components[1]) ?? 0
            time.second = Int(components[2]) ?? 0
        default:
            fatalError("Invalid time format!")
        }
        return time
    }
}
