//
//  StopwatchView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import SwiftUI

struct StopwatchView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: StopwatchViewModel
    @State var entity: FetchedResults<ActivityEntity>.Element
    
    var body: some View {
        VStack {
            Spacer()
            Text(vm.elapsedTime.toString())
                .font(.system(size: 50))
                .onTapGesture(count: 1) { vm.displayMode = .start }
            Spacer()
            HStack {
                switch(vm.displayMode) {
                case .setup, .start:
                    Button(action: {
                        vm.start()
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
            .padding(50)
        }
        .onChange(of: vm.mode) { _, newValue in
            if newValue == TimerMode.finish {
                vm.addRecord(entity, context: managedObjContext)
                dismiss()
            }
        }
    }
}
