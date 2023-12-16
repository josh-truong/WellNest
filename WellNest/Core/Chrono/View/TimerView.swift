//
//  Timer.swift
//  WellNest
//
//  Created by Joshua Truong on 11/29/23.
//
import SwiftUI
import CircularProgress

struct TimerView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var chrono: ChronoViewModel
    
    @State private var time: TimeModel = .init()
    
    var body: some View {
        VStack {
            CircularProgressView(count: 0, total: 0, progress: chrono.model.progress, lineWidth: 15, showText: false)
                .overlay {
                    VStack {
                        Text("\(time.hr) h \(time.min) m \(time.sec) s")
                        Spacer()
                        if (chrono.displayMode == .setup) {
                            TimePickerView(hour: $time.hr, minute: $time.min, second: $time.sec)
                                .onChange(of: time) { _, _ in
                                    chrono.setup(time.hr, time.min, time.sec)
                                }
                        }
                        else {
                            Text(chrono.model.remaining.toString())
                                .font(.system(size: 50))
                        }
                        
                        Spacer()
                        
                        if (chrono.displayMode != .setup) {
                            HStack {
                                Image(systemName: "bell.fill")
                                Text(chrono.model.eta.toStringCivilian())
                            }
                        }
                    }
                    .padding(70)
                }
                .padding(20)
        }
    }
}
