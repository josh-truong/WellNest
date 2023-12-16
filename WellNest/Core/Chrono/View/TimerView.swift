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
    @EnvironmentObject var vm: TimerViewModel
    
    @State var entity: FetchedResults<ActivityEntity>.Element
    @State private var time: (hr: Int, min: Int, sec: Int) = (0,0,0)
    
    var body: some View {
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
                            Text(vm.remainingDuration.toString())
                                .font(.system(size: 50))
                                .onTapGesture(count: 1) { vm.displayMode = .start }
                        }
                        
                        Spacer()
                        
                        if (vm.displayMode != .setup) {
                            HStack {
                                Image(systemName: "bell.fill")
                                Text(vm.eta.toStringCivilian())
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
                        vm.setup(hour: time.hr, minute: time.min, second: time.sec)
                    }) {
                        Text("Start")
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                case .pause:
                    Button(action: {
                        vm.pause()
                    }) {
                        Text("Pause")
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    
                case .resume, .finish:
                    Button(action: {
                        vm.resume()
                    }) {
                        Text("Resume")
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    Button(action: {
                        vm.finish()
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
                    vm.addRecord(entity, context: managedObjContext)
                    dismiss()
                }
            }
            .padding(50)
        }
    }
}
