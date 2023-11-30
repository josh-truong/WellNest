//
//  Timer.swift
//  WellNest
//
//  Created by Joshua Truong on 11/29/23.
//
import SwiftUI
import CircularProgress

struct TimerView: View {
    @State private var time: (hr: Int, min: Int, sec: Int) = (0,0,0)
    @StateObject private var vm = TimerViewModel()
    
    var body: some View {
        VStack {
            CircularProgressView(count: 0, total: 0, progress: vm.progress, lineWidth: 15, showText: false)
                .overlay {
                    VStack {
                        Text("\(time.hr) h \(time.min) m \(time.sec) s")
                        Spacer()
                        if (vm.mode == .setup) {
                            TimePickerView(hour: $time.hr, minute: $time.min, second: $time.sec)
                        }
                        else {
                            Text(vm.timeRemainingFormatted)
                                .font(.system(size: 70))
                                .onTapGesture(count: 1) { vm.mode = .start }
                        }
                        
                        Spacer()
                        if (!vm.eta.isEmpty) {
                            HStack {
                                Image(systemName: "bell.fill")
                                Text(vm.eta)
                            }
                        }
                    }
                    .padding(70)
                }
                .padding(20)
            HStack {
                switch(vm.mode) {
                case .setup, .start:
                    Button("Start", action: {
                        vm.startTimer(hour: time.hr, minute: time.min, second: time.sec)
                    })
                case .pause:
                    Button("Pause", action: {
                        vm.pauseTimer()
                    })
                case .resume, .finish:
                    Button("Resume", action: {
                        vm.resumeTimer()
                    })
                    Button("Finish", action: {
                        vm.finishTimer()
                    })
                }
            }
            .padding(50)
        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
