//
//  ChronoView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import SwiftUI

struct ChronoView: View {
    @State var entity: FetchedResults<ActivityEntity>.Element
    @State private var viewTag: Int = 1
    
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
        }
    }
}
