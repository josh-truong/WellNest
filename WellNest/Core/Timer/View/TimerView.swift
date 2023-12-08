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
    
    @State var entity: FetchedResults<ActivityEntity>.Element
    @State private var time: (hr: Int, min: Int, sec: Int) = (0,0,0)
    @StateObject private var vm = TimerViewModel()
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                CircularProgressView(count: 0, total: 0, progress: vm.progress, lineWidth: 15, showText: false)
                    .overlay {
                        VStack {
                            Text("\(time.hr) h \(time.min) m \(time.sec) s")
                            Spacer()
                            if (vm.displayMode == .setup) {
                                TimePickerView(hour: $time.hr, minute: $time.min, second: $time.sec)
                            }
                            else {
                                Text(vm.timeRemainingFormatted)
                                    .font(.system(size: 50))
                                    .onTapGesture(count: 1) { vm.displayMode = .start }
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
                    switch(vm.displayMode) {
                    case .setup, .start:
                        Button(action: {
                            vm.startTimer(hour: time.hr, minute: time.min, second: time.sec)
                        }) {
                            Text("Start")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    case .pause:
                        Button(action: {
                            vm.pauseTimer()
                        }) {
                            Text("Pause")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        
                    case .resume, .finish:
                        Button(action: {
                            vm.resumeTimer()
                        }) {
                            Text("Resume")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        Button(action: {
                            vm.finishTimer(entity, context: managedObjContext)
                        }) {
                            Text("Finish")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                }
                .onChange(of: vm.mode) { _, newValue in
                    if newValue == TimerMode.finish {
                        vm.finishTimer(entity, context: managedObjContext)
                        dismiss()
                    }
                }
                .padding(50)
                .navigationTitle(entity.activity.name)
                .toolbar {
                    ToolbarItem {
                        Button("", systemImage: "bell", action: {showModal.toggle()})
                    }
                }
                .sheet(isPresented: $showModal) {
                    ReminderView(entity: entity)
                }
                .onDisappear { dismiss() }
            }
        }
        
    }
}
