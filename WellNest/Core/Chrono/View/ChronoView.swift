//
//  ChronoView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import SwiftUI

struct ChronoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var chrono: ChronoViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var entity: FetchedResults<ActivityEntity>.Element
    
    @State private var viewTag: ChronoType = .timer
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $viewTag) {
                    if !chrono.isRunning {
                        Text("Timer").tag(ChronoType.timer)
                        Text("Stopwatch").tag(ChronoType.stopwatch)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: viewTag) { _, new in chrono.setType(new) }
                .padding()
                
                Spacer()
                
                switch(viewTag) {
                case .timer:
                    TimerView()
                case .stopwatch:
                    StopwatchView()
                }
                Spacer()
                
                HStack {
                    switch(chrono.displayMode) {
                    case .setup, .start:
                        Button(action: {
                            chrono.start()
                        }) {
                            Text("Start")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    case .pause:
                        Button(action: {
                            chrono.pause()
                        }) {
                            Text("Pause")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        
                    case .resume, .finish:
                        Button(action: {
                            chrono.resume()
                        }) {
                            Text("Resume")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        Button(action: {
                            chrono.finish()
                            dismiss()
                        }) {
                            Text("Finish")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                }
                .padding(50)
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
            .onAppear() { chrono.setupEntity(entity, context: managedObjContext) }
            .onDisappear { dismiss() }
        }
    }
}
