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
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        VStack {
            CircularProgressView(count: 0, total: 0, progress: viewModel.progress, lineWidth: 15, showText: false)
                .overlay {
                    VStack {
                        Text("\(time.hr) h \(time.min) m \(time.sec) s")
                        Spacer()
                        if (viewModel.mode == .setup) {
                            TimePickerView(hour: $time.hr, minute: $time.min, second: $time.sec)
                        }
                        else {
                            Text(viewModel.timeRemainingFormatted)
                                .font(.system(size: 70))
                                .onTapGesture(count: 1) { viewModel.mode = .start }
                        }
                        
                        Spacer()
                        if (!viewModel.eta.isEmpty) {
                            HStack {
                                Image(systemName: "bell.fill")
                                Text(viewModel.eta)
                            }
                        }
                    }
                    .padding(70)
                }
                .padding(20)
            HStack {
                switch(viewModel.mode) {
                case .setup, .start:
                    Button("Start", action: {
                        viewModel.setupTimer(hour: time.hr, minute: time.min, second: time.sec)
                    })
                case .pause:
                    Button("Pause", action: {
                        viewModel.pauseTimer()
                    })
                case .resume, .finish:
                    Button("Resume", action: {
                        viewModel.resumeTimer()
                    })
                    Button("Finish", action: {
                        viewModel.finishTimer()
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
