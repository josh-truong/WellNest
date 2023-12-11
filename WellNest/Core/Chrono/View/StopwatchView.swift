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
    
    @State var entity: FetchedResults<ActivityEntity>.Element
    @StateObject private var vm = StopwatchViewModel()
    
    var body: some View {
        NavigationStack {
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
                            vm.addRecord(entity, context: managedObjContext)
                        }) {
                            Text("Finish")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                }
                .padding()
            }
        }
    }
}
