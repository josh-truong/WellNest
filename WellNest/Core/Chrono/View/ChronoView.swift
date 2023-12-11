//
//  ChronoView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import SwiftUI

struct ChronoView: View {
    @Environment(\.dismiss) var dismiss
    @State var entity: FetchedResults<ActivityEntity>.Element
    @State private var viewTag: Int = 1
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $viewTag) {
                    Text("Timer").tag(0)
                    Text("Stopwatch").tag(1)
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
            }
            .onDisappear {
                viewTag = 0
                dismiss()
            }
        }
    }
}