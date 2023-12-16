//
//  ChronoView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import SwiftUI

struct ChronoView: View {
    @EnvironmentObject var timer: TimerViewModel
    @EnvironmentObject var stopwatch: StopwatchViewModel
    @Environment(\.dismiss) var dismiss
    @State var entity: FetchedResults<ActivityEntity>.Element
    @State private var viewTag: Int = 0
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $viewTag) {
                    if (!timer.isRunning && !stopwatch.isRunning) {
                        Text("Timer").tag(0)
                        Text("Stopwatch").tag(1)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Spacer()
                
                if viewTag == 0 {
                    TimerView(entity: entity)
                } else if viewTag == 1 {
                    StopwatchView(entity: entity)
                }
                Spacer()
            }
            .navigationTitle(entity.activity.name)
            .toolbar {
                ToolbarItem {
                    Button("", systemImage: "bell", action: {showModal.toggle()})
                }
            }
            .sheet(isPresented: $showModal) {
                ReminderView(entity: entity)
                    .presentationDetents([.height(600)])
                    .presentationCornerRadius(20)
            }
            .onDisappear { dismiss() }
        }
    }
}
